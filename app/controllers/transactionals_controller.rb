class TransactionalsController < ApplicationController
  include UploadHandler
  
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
    collect_ri_module_requests_from_html @transactional
    replace_ri_modules_with_xsl_modules @transactional , @modules

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @transactional }
    end
  end

  def replace_ri_modules_with_xsl_modules transactional , modules
    modules.each_with_index do |mod , i|
      i+=1 # because computers index from zero, but we dont.
      @transactional.shell.sub!(mod , i.to_s) 
    end
    @transactional.xsl_modules.each do |xsl_mod|
      @transactional.shell.sub!(/\$#{xsl_mod.order.to_s}\$/, xsl_mod.xslt)
    end
  end

  def collect_ri_module_requests_from_html(html)
    @modules = @transactional.shell.scan(/\$(.*?)\$/m).flatten
    @modules.each_with_index do |mod , i|
      if !mod.include? "document"
        @modules[i] = nil
      end
    end
    @modules.compact!
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
        handle_assets @transactional

        format.html { redirect_to @transactional, notice: "Transactional was successfully created." }
        format.json { render json: @transactional, status: :created, location: @transactional }
      else
        format.html { render action: "new" }
        format.json { render json: @transactional.errors, status: :unprocessable_entity }
      end
    end
  end

  def handle_assets object
    unzip object.folder.path, File.dirname(object.folder.path) , true 
    # push_assets_to_s3 object
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
