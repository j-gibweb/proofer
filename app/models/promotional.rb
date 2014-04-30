class Promotional < ActiveRecord::Base
  attr_accessible :html, :folder, :test_email_count, :qa_email_count, :missing_images
  serialize :missing_images

  has_attached_file :folder,
    :url  => "/assets/:id/:basename.:extension",
    :path => ":rails_root/public/assets/promotionals/:id/:basename.:extension" 

  validates_attachment_content_type :folder, :content_type => ["application/zip", "text/html", "text/htm"]

  def update_markup!
    helper = HtmlParser::Helper.new(
      :bucket_name => "proofer-stage",
      :html => self.html,
      :object => self,
      :path => self.folder.path
    )
    self.missing_images = helper.parse!
    self.html = helper.html
    self.save!
  end

  def read_local_html
    self.html = File.read(HtmlParser::Helper.html_file_path(self.folder.path))
    self.save!
  end

  def set_subject_line_and_increment_number_of_sent_emails recipient_list
    parent_campaign = Campaign.find(self.campaign_id)
    if recipient_list.purpose == "QA"
      self.qa_email_count += 1
      @subject = "QA: #{parent_campaign.client_name}-#{parent_campaign.name} test ##{self.qa_email_count}" 
      self.save!
    elsif recipient_list.purpose == "Testing"
      self.test_email_count += 1
      @subject = "#{parent_campaign.client_name}-#{parent_campaign.name} test ##{self.test_email_count}" 
      self.save!
    end
    return @subject
  end

end