class TransactionalsController < ApplicationController
  include UploadHandler
  include HtmlParser

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
    
    @transactional.shell = go_nokogiri!(@transactional , @transactional.shell , @transactional.folder.path , "proofer-stage")

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

  def handle_assets object
    if Dir["#{File.dirname(object.folder.path)}/*"].find {|e| /.zip/ =~ e }
      unzip object.folder.path, File.dirname(object.folder.path) , true 
    end
    push_assets_to_s3 object , "proofer-stage" # second argument is the s3 bucket name

  end

  def create
    @transactional = Transactional.new(params[:transactional])
    @parent_campaign_id = params[:campaign].keys.first 
    
    respond_to do |format|
      if @transactional.save
        
        Campaign.find(@parent_campaign_id).transactional = @transactional
        handle_assets @transactional

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

        handle_assets @transactional
        
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
end
