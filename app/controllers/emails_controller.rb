
class EmailsController < ApplicationController

  

  before_filter :admin_user! , :only => [:index , :delete_everything]

  def index
    # @emails = current_user.campaigns.collect {|campaign| campaign.emails }.flatten
    @emails = Email.all
    respond_to do |format|
      format.html # index.html.erb
    end
  end


  def show
    @email = Email.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    get_destination_emails
    @email = Email.new
    @parent_campaign = Campaign.find(params[:campaign])
    @status = params[:status]
    @parent_campaign.status = @status
    @parent_campaign.updated_at = Time.now
    @parent_campaign.save
    respond_to do |format|
      format.html  
    end
  end

  def get_destination_emails
    if current_user
      current_user_lists = current_user.recipient_lists
      all_users_lists = RecipientList.where("all_users = ?" , true)
      @recipient_lists  = current_user_lists | all_users_lists 
    end
  end


  def edit
    @email = Email.find(params[:id])
  end

  def create
    @email = Email.new(params[:email])
    @parent_campaign = Campaign.find(@email.campaign_name) #@email.campaign_name is not ACTUALLY used to store the parent campaign

    if params[:ignore_images]
      @ignore_images = true
    else
      @ignore_images = false
    end

    if params[:additional_recipients_only]
      @additional_recipients_only = true
    else
      @additional_recipients_only = false
    end

    respond_to do |format|
      if @email.save      

          # send .html || .htm files on their own with no dir or zip or anything
          # unless @email.folder.path.split(".").last == "html" #|| "htm" 
          unless @email.folder.path.split(".").last.include? "htm" 
            @email.unzip(@email.folder.path, File.dirname(@email.folder.path) , true)
          end

          @email.set_campaign_name
          @email.set_html_file_name
          @email.parse_html(@ignore_images)
          
          if @email.parse_status == true
            notice = "The email sent successfully."
            @email.push_assets_to_s3
            @email.send_emails_via_ses(current_user , @additional_recipients_only)
            @email.remove_zip
            @parent_campaign.emails << @email 
          else
            notice = "#{@email.markup}" #fail notice w/ missing images array
            # makeshift and dumb - ps. I hate you Rails controller
            status = @email.status
            @the_failed_email =  @email
            @the_failed_email.remove_zip
            @the_failed_email.destroy
            # makeshift and dumb - ps. I hate you Rails controller
            if status == "Testing"
              @email = new_email_path(:campaign => @parent_campaign , :status => "Testing") 
            elsif status == "QA"
              @email = new_email_path(:campaign => @parent_campaign , :status => "QA") 
            end
          end

        # @email.test
        # @email.remove_zip

        notice = "something went wrong" if notice.nil?  
        format.html { redirect_to @email, notice: "#{notice.truncate(1024)}" }   #{if message !=nil message}
        format.json { render json: @email, status: :created, location: @email }
      else
        format.html { render action: "new" }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @email = Email.find(params[:id])
    respond_to do |format|
      if @email.update_attributes(params[:email])
        format.html { redirect_to @email, notice: ">>  #{params} <<" }
      else
        format.html { render action: "edit" }
      end
    end
  end


  def destroy
    @email = Email.find(params[:id])
    @email.destroy
    respond_to do |format|
      format.html { redirect_to emails_url , notice: "you've successfully destroyed that email, really good job." }
    end
  end


  # in it's current form, this method deletes all instances of email and their respective s3 bucks, currently belonging to the current_user
  def delete_everything  
    Email.clear_s3(current_user)
    @emails = current_user.campaigns.collect {|campaign| campaign.emails }.flatten
    @emails.collect {|email| email.delete }
    respond_to do |format|
      format.html {redirect_to emails_path }
    end
  end

end
