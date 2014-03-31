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

  attr_accessible :recipients, :subject , :folder , :markup , :campaign_name , :status , :additional_recipients , :html_file_name 

  attr_accessor :parse_status , :html_file , :mso_conditionals , :images_folder_name

  has_and_belongs_to_many :campaigns

  has_attached_file :folder ,
	:url  => "/assets/:id/:basename.:extension",
	# :path => ":rails_root/public/assets/:id/:basename.:extension" 
	# maybe a temp directory for uploads in general? I'm not sure yet. 
	:path => ":rails_root/public/assets/emails/:id/:basename.:extension" 

	validates_attachment_content_type :folder , :content_type => ["application/zip" , "text/html" , "text/htm"]

	# validates_presence_of :folder 

	def parse_html(ignore_images) # ignore_images is boolean , it means, ignore images?
		html_file = File.read("#{self.html_path}")

		# catch invalid chars
		self.html_file = html_file.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '<span style="font-size:20px;color:#ca3536;"> INVALID CHARACTER </span>')
		
		# catch MSO 9 conditional classes
		parse_commented_conditionals		

		# parse HTML with nokogiri
		page = Nokogiri::HTML(self.html_file) 

		# select tags to inspect from html
		tags = {'img' => 'src' , 'td' => 'background', 'table' => 'background'}

		# determine name of dir containing the images and save it 			
		self.images_folder_name = page.search(tags.first[0]).first.first[1].split("/").first

		images_missing_from_folder = []
		# parse HTML with nokogiri 
		page.search(tags.keys.join(",")).each do |node|
			url_param = tags[node.name]
			src = node[url_param]
			unless src == nil or src.include? "http" or src.length < 5 
				if image_names_in_uploads_folder.include? src.split("/").last || ignore_images == true
					uri = URI.parse(src)
					node[url_param] = uri.path.sub(self.images_folder_name,"http://s3.amazonaws.com/proofer/#{self.campaign_name}/#{self.images_folder_name}") 
				else 
					images_missing_from_folder << src.split("/").last.sub(self.images_folder_name+"\/","")
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
					change = parser.find_by_selector(selector)[0].sub(self.images_folder_name,"http://s3.amazonaws.com/proofer/#{self.campaign_name}/#{self.images_folder_name}")
					css_string.sub!(parser.find_by_selector(selector)[0],change) 
				end
			end 
		end
		# push parsed css into parsed html
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
			self.markup = "Missing from /#{self.images_folder_name}/ >>> #{images_missing_from_folder.to_s}"
			self.parse_status = false
			self.save
		end
	end

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

	def upload_path # the path to the root of the uploaded zip
		"#{File.dirname(self.folder.path)}"
	end

	def path_to_project # the path to the .htm file within the uploaded zip
		File.dirname(Dir[File.dirname(self.folder.path).to_s+"/**/*.htm*"][0])
	end

	def html_path # just the html file path 
		Dir["#{path_to_project}/*.htm*"][0]
	end

	def set_campaign_name 
		# campaign_name is used for the name of the S3 bucket, thus all the gibberish , name needs to be 100% unique & free of spaces / underscores
		self.campaign_name = html_path.split("/").last.split(".").first[0..20].gsub(/ /,"").gsub(/_/,"-").gsub(/\+/,"-").downcase+"-#{Time.now.to_i}"
		self.save
	end

	def set_html_file_name # this is being done in hopes of cooking up some real cool UI magic later on, not sure yet.
		self.html_file_name = html_path.split("/").pop
		self.save
	end

	def image_names_in_uploads_folder # returns an array full of all the images used in the email
		Dir["#{path_to_project}/#{self.images_folder_name}/*"].map {|each| each.split("/").last}  
	end

	def parse_commented_conditionals
		self.mso_conditionals = [] 
		index = 0 
		while self.html_file.match(/<!--(.*?)-->/m).to_s != "" do  # while there are any comments, i.e: mso fix code - replace the code with unique iden + a digit
			self.mso_conditionals[index] = self.html_file.match(/<!--(.*?)-->/m).to_s
			self.html_file.sub!( self.mso_conditionals[index] , "_COMMENT_#{index.to_s}" ) 
			index += 1 
		end
	end

	def replace_commented_conditionals
		index = 0
		self.mso_conditionals.each do |condition|
			if condition.include? "src=\"#{self.images_folder_name}/"
				condition.sub!(self.images_folder_name,"http://s3.amazonaws.com/proofer/#{self.campaign_name}/#{self.images_folder_name}")
			end
			self.html_file.sub!( "_COMMENT_#{index.to_s}" , condition ) 
			index += 1
		end
	end

	def send_emails_via_ses(user , additional_recipients_only)
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
		ses = AWS::SES::Base.new(:access_key_id => 'AKIAIIY3JNRNOMPO4ROA', :secret_access_key => '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')

		ses.send_email(
			:to => "#{recipient}",
			:from => "\"#{user.name}\" <j.gibweb@gmail.com>",
			:subject => "#{self.subject}",
			:html_body => "#{self.markup}"
			)
	end

	def push_assets_to_s3
		file_paths = Dir["#{path_to_project}/**/*"]
		directory = FOG_STORAGE.directories.get("proofer")
		threads = []
		file_paths.each do |f|
			next if f.include? "__MACOSX" or File.directory?(f)
			threads << Thread.new{
				f_path = f.sub(path_to_project, "")
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
		path = upload_path if self.folder.path != nil
		system("rm -r #{path}")
	end



end
