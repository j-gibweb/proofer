class TransactionalsController < ApplicationController
  include UploadHandler
  include HtmlParser
  include EmailHandler

  def index
    @transactionals = Transactional.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transactionals }
    end
  end

  def show
    @transactional = Transactional.find(params[:id])
    @parent_campaign = Campaign.find(@transactional.campaign_id)
    @transactional.handle_ri_module_requests_in_html
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @transactional }
    end
  end

  def new
    @transactional = Transactional.new
    @parent_campaign =  params[:campaign]
    respond_to do |format|
      format.html 
      format.json { render json: @transactional }
    end
  end

  def edit
    @transactional = Transactional.find(params[:id])
  end

  def create
    @transactional = Transactional.new(params[:transactional])
    @parent_campaign_id = params[:campaign].keys.first 
    respond_to do |format|
      if @transactional.save
        Campaign.find(@parent_campaign_id).transactional = @transactional    
        update_s3_bucket @transactional
        format.html { redirect_to @transactional, notice: "Transactional was successfully created." }
        format.json { render json: @transactional, status: :created, location: @transactional }
      else
        format.html { render action: "new" }
        format.json { render json: @transactional.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @transactional = Transactional.find(params[:id])
    respond_to do |format|
      if @transactional.update_attributes(params[:transactional])
        update_s3_bucket @transactional
        format.html { redirect_to @transactional, notice: 'Transactional was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @transactional.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @transactional = Transactional.find(params[:id])
    @transactional.destroy
    respond_to do |format|
      format.html { redirect_to transactionals_url }
      format.json { head :no_content }
    end
  end

  def send_test_email
    @transactional = Transactional.find(params[:id])
    @transactional.handle_ri_module_requests_in_html
    recipients = RecipientList.find_by_name("Testing").list
    subject = Campaign.find(@transactional.campaign_id).name
    send_email(:recipients => recipients , :user => current_user , :html => @transactional.shell , :subject => subject)    
    respond_to do |format|
      format.html { redirect_to @transactional, notice: "#{subject} Test Email Sent" }      
    end
  end

  def update_s3_bucket transactional
    handle_s3_assets transactional
    transactional.shell = go_nokogiri!(transactional , transactional.shell , transactional.folder.path , "proofer-stage") if transactional.folder.path
    transactional.save!
  end

  def handle_s3_assets object
    if Dir["#{File.dirname(object.folder.path)}/*"].find {|e| /.zip/ =~ e }
      unzip object.folder.path, File.dirname(object.folder.path) , true 
      push_assets_to_s3 object , "proofer-stage" # second argument is the s3 bucket name
    end
  end

end
