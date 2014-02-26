class Email < ActiveRecord::Base
	require 'rubygems'
	require 'zip/zip'
	require 'find'
	require 'fileutils'
	require 'nokogiri'
	require 'css_parser'
	include CssParser
	require 'fog'

	require 'open-uri'


  validates_presence_of :folder 

  attr_accessible :recipients, :subject , :folder , :markup , :campaign_name , :status , :additional_recipients , :html_file_name 

  attr_accessor :parse_status , :html_file , :mso_conditionals 


  has_and_belongs_to_many :campaigns

  has_attached_file :folder ,
	:url  => "/assets/:id/:basename.:extension",
	:path => ":rails_root/public/assets/:id/:basename.:extension" 


	# Paperclip.interpolates :prod_folder do |attachment, style|
	#   attachment
	# end

	def unzip(zip, unzip_dir, remove_after = false)
		Zip::ZipFile.open(zip) do |zip_file|
			zip_file.each do |f|
				f_path=File.join(unzip_dir, f.name)
				FileUtils.mkdir_p(File.dirname(f_path))
				zip_file.extract(f, f_path) unless File.exist?(f_path)
			end
		end
		FileUtils.rm(zip) if remove_after
	end

	# "#{self.folder.path.split("/").reverse.drop(1).reverse.join("/")}"
	def upload_path
		"#{File.dirname(self.folder.path)}"
	end

	# "#{recursive_find(File.dirname(self.folder.path))}"
	def path_to_project
		File.dirname(Dir[File.dirname(self.folder.path).to_s+"/**/*.htm*"][0])
		# because sometimes .html files are just .htm  >:{  
	end


	def markup_path
		Dir["#{path_to_project}/*.htm*"][0]
	end

	def set_campaign_name
		# self.campaign_name = Dir["#{path_to_project}/*.html"][0].split("/").last.split(".").first[0..20].gsub(/ /,"").gsub(/_/,"-").downcase+"-#{Time.now.to_i}"
		self.campaign_name = markup_path.split("/").last.split(".").first[0..20].gsub(/ /,"").gsub(/_/,"-").gsub(/\+/,"-").downcase+"-#{Time.now.to_i}"
		self.save
	end

	def set_html_file_name
		self.html_file_name = markup_path.split("/").pop
		self.save
	end

	def image_names_in_uploads_folder
		Dir["#{path_to_project}/images/*"].map {|each| each.split("/").last}  
		# Dir["#{path_to_project}/*/*"].map {|each| each.sub(path_to_project.to_s,"")} 
		# this will only work if the folder with the images in it, is actually named images....  better to derive the name from the html
	end

	def parse_commented_conditionals
		self.mso_conditionals = [] 
		index = 0 
		while self.html_file.match(/<!--(.*?)-->/m).to_s != "" do 
			self.mso_conditionals[index] = self.html_file.match(/<!--(.*?)-->/m).to_s
			self.html_file.sub!( self.mso_conditionals[index] , "_COMMENT_#{index.to_s}" ) 
			index += 1 
		end
	end

	def replace_commented_conditionals
		index = 0
		self.mso_conditionals.each do |condition|
			if condition.include? "src=\"images/"
				condition.sub!(/images/,"http://s3.amazonaws.com/proofer/#{self.campaign_name}/images")
			end
			self.html_file.sub!( "_COMMENT_#{index.to_s}" , condition ) 
			index += 1
		end
	end

	def parse_html(ignore_images)
		html_file = File.read("#{self.markup_path}")
		# catch invalid chars
		self.html_file = html_file.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '<span style="font-size:20px;color:#ca3536;"> INVALID CHARACTER </span>')
		
		# catch MSO 9 conditional classes
		parse_commented_conditionals		

		# parse HTML with nokogiri
		page = Nokogiri::HTML(self.html_file)
		tags = {'img' => 'src' , 'td' => 'background', 'table' => 'background'}
		# First time through is to get a collection of all the image names in the html
		images_in_the_html = [] 
		page.search(tags.keys.join(",")).each do |node|
			url_param = tags[node.name]
			src = node[url_param]
			unless src == nil or src.include? "http" or src.length < 4
				uri = URI.parse(src)
				images_in_the_html << uri.path.sub(/images\//,"")
			end
		end	
		# check the images in the folder -> @valid_images and the images in the html - and get the intersection
		images_missing_from_folder = images_in_the_html.reject {|x| image_names_in_uploads_folder.include? x }.uniq
		# Second time through only occurs if there are no missing images in the images/ folder
		if images_missing_from_folder.empty? or ignore_images == true
			page.search(tags.keys.join(",")).each do |node|
				url_param = tags[node.name]
				src = node[url_param]
				unless src == nil or src.include? "http"
					uri = URI.parse(src)
					node[url_param] = uri.path.sub(/images/,"http://s3.amazonaws.com/proofer/#{self.campaign_name}/images") 
				end
			end	
		end

		# parse CSS with css_parser gem
		css_string = page.to_html.match(/<style(.*?)<\/style>/m).to_s
		parser = CssParser::Parser.new
		parser.add_block!(css_string)
		parser.each_selector do |selector, declarations, specificity|
			if declarations.include? "background-image" #and "images/"??????
				unless declarations.include? "http"
					change = parser.find_by_selector(selector)[0].sub(/images/,"http://s3.amazonaws.com/proofer/#{self.campaign_name}/images")
					css_string.sub!(parser.find_by_selector(selector)[0],change) 
				end
			end 
		end
		# push parsed css into parsed html
		# processed_markup = page.to_html.sub(/<style(.*)<\/style>/m,css_string)
		self.html_file = page.to_html.sub(/<style(.*)<\/style>/m,css_string)

		# push MSO 9 classes back into html
		replace_commented_conditionals

		# success / no missing images
		if images_missing_from_folder.empty? or ignore_images == true
			self.markup = self.html_file  #+ unused_images_in_folder.to_s   #.force_encoding('utf-8')
			self.parse_status = true
			self.save
		else
		# failure due to missing images
			self.markup = "Missing from /images/ >>> #{images_missing_from_folder.to_s}"
			self.parse_status = false
			self.save
		end
	end






	def send_emails_via_ses(user , additional_recipients_only)
		# HERE TEST 
		if additional_recipients_only && self.additional_recipients
			self.recipients = self.additional_recipients
		elsif self.additional_recipients
			self.recipients += "," + self.additional_recipients
		end
		self.save
		self.recipients.split(",").each do |recipient|
			send_email(recipient , user)
		end
	end

	def send_email(recipient , user)
		# these values need to be removed and set on the production server as ENV variables
		# also var -> ses  could possibly be @ses and only instantiated once on the Class level - much like @connection
		ses = AWS::SES::Base.new(:access_key_id => 'AKIAIIY3JNRNOMPO4ROA', :secret_access_key => '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')
		# these values need to be removed and set on the production server as ENV variables

		ses.send_email(
			:to => "#{recipient}",
			:from => "\"#{user.name}\" <j.gibweb@gmail.com>",
			:subject => "#{self.subject}",
			:html_body => "#{self.markup}"
			)
	end

	# def test
	# 	test = []
	# 	directories = []
	# 	image_paths = Dir["#{path_to_project}/**/*"]

	# 	image_paths.each do |img|
	# 		next if img.include? "__MACOSX" or File.directory?(img)
	# 		self.subject = File.dirname(img) 
	# 		test << img.gsub(path_to_project , "")	
	# 		test << "<br />"
	# 	end
	
	# 	self.markup = test.to_s #FOG_STORAGE.directories.find(:key => "proofer", :public => true)
	# 	self.save
	# end

	def push_assets_to_s3
		file_paths = Dir["#{path_to_project}/**/*"]
		directory = FOG_STORAGE.directories.get("proofer")
		threads = []
		file_paths.each do |f|
			next if f.include? "__MACOSX" or File.directory?(f)
			threads << Thread.new{
				# f_path = f.split("/").pop
				f_path = f.gsub(path_to_project, "")
				file = directory.files.create( :key => "#{self.campaign_name}#{f_path}", :body => File.open("#{f}"), :public => true )	
			}
		end
		threads.each(&:join)
	end


	def self.clear_s3(user)
		start = Time.now
		FOG_STORAGE.directories.each do |directory|
			directory.files.each do |file| 
				user.campaigns.map {|campaign| campaign.emails.map {|email| email.campaign_name}}.flatten.each do |camp_name|
					if file.key.include? "#{camp_name}"
						Thread.new{
							file.destroy
						}
					end
				end
			end
		end
		finish = Time.now - start 
		puts "THE AMOUNT OF TIME IS TOOK IS  >>>> #{finish}"
	end

	def remove_zip
		# removes -r ./public/assets/{:id}/
		# path = path_to_project if self.folder.path != nil
		path = upload_path if self.folder.path != nil
		system("rm -r #{path}")
		# test with -rf
		# system("rm -rf #{path}")
		puts "folder deleted"
	end



end
