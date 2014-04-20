class Promotional < ActiveRecord::Base
  attr_accessible :html , :folder 

  has_attached_file :folder,
  :url  => "/assets/:id/:basename.:extension",
  :path => ":rails_root/public/assets/promotionals/:id/:basename.:extension" 
  validates_attachment_content_type :folder, :content_type => ["application/zip", "text/html", "text/htm"]

  def update_markup! 
    options = {:object => self, :html => self.html, :path => self.folder.path, :bucket_name => "proofer-stage"} 
    helper = HtmlParser::Helper.new(options)
    self.html = helper.html
    self.save!
  end

  def read_local_html
    self.html = File.read(HtmlParser::Helper.html_file_path(self.folder.path))
    self.save!
  end

end
