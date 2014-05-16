class PromotionalsController < ApplicationController
  # include HtmlParser
  # include S3
  # require 'SES/email_handler'
  # include SES
  
  def index
    @promotionals = Promotional.all

    respond_to do |format|
      format.html 
      format.json { render json: @promotionals }
    end
  end
  
  def show
    @promotional = Promotional.find(params[:id])
    @parent_campaign = Campaign.find(@promotional.campaign_id)
    @recipients = RecipientList.get_recipient_lists_by_user(current_user)
    # @hosted_html_path = "https://s3.amazonaws.com/proofer-stage/#{S3::Helper.unique_file_name(@promotional)}/#{File.basename(HtmlParser::Helper.html_file_path(@promotional.folder.path))}" 
    
    if @recipients.find {|l| l.preferred? }
      @default_mailing_list = @recipients.find {|l| l.preferred? }.id
    else
      @default_mailing_list = @recipients.select {|l| l.all_users && l.purpose == "Testing"}.first.id
    end

    respond_to do |format|
      format.html 
      format.json { render json: @promotional }
    end
  end
  
  def new
    @promotional = Promotional.new

    respond_to do |format|
      format.html 
      format.json { render json: @promotional }
    end
  end
  
  def edit
    @promotional = Promotional.find(params[:id])
  end
  
  def create
    @promotional = Promotional.new(params[:promotional])
    @parent = Campaign.find(params[:campaign])

    respond_to do |format|
      if @promotional.save
        handle_uploads @promotional if params[:promotional][:folder]
        @parent.promotional = @promotional
        format.html { redirect_to @promotional, notice: 'Promotional was successfully created.' }
        format.json { render json: @promotional, status: :created, location: @promotional }
      else
        format.html { render action: "new" }
        format.json { render json: @promotional.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    @promotional = Promotional.find(params[:id])
    if params[:promotional][:folder]
      FileUtils.rm_rf(File.dirname(@promotional.folder.path)) 
      S3::Helper.delete_bucket(@promotional, "proofer-stage") 
    end
    respond_to do |format|
      if @promotional.update_attributes(params[:promotional])
        @promotional.missing_images = handle_uploads @promotional if params[:promotional][:folder]
        
        format.html { redirect_to @promotional, notice: "Promotional was successfully updated. #{@all_missing_images}" }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @promotional.errors, status: :unprocessable_entity }
      end
    end
  end

  def handle_uploads promotional
    S3::Helper.unzip(@promotional.folder.path, File.dirname(@promotional.folder.path), true)
    S3::Helper.push_assets_to_s3(@promotional, "proofer-stage")
    @promotional.read_local_html
    @promotional.update_markup!
  end
  
  def send_test_email
    promotional = Promotional.find(params[:id])
    @recipient_list = RecipientList.find(params[:recipient_list])
    subject = promotional.set_subject_line_and_increment_number_of_sent_emails(@recipient_list)
    
    SES::EmailHandler.send_email(
      :recipients => @recipient_list.list, 
      :user => current_user, 
      :subject => subject, 
      :html => promotional.html
    )
    
    respond_to do |format|
      format.html { redirect_to promotional, notice: "#{@recipient_list.purpose} Email Sent" }      
    end
  end

  def destroy
    @promotional = Promotional.find(params[:id])
    S3::Helper.delete_bucket(@promotional, "proofer-stage")
    @promotional.destroy
    respond_to do |format|
      format.html { redirect_to promotionals_url }
      format.json { head :no_content }
    end
  end

end
