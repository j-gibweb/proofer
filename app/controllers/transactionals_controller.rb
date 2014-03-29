class TransactionalsController < ApplicationController
  # GET /transactionals
  # GET /transactionals.json
  def index
    @transactionals = Transactional.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transactionals }
    end
  end

  # GET /transactionals/1
  # GET /transactionals/1.json
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
      @transactional.shell.sub!(mod , i.to_s) 
    end
    @transactional.xsl_modules.each do |xsl_mod|
      # xsl needs to actually be xslt rendered by nokogiri
      # @transactional.shell.sub!(xsl_mod.order.to_s , xsl_mod.xsl)
    end
    # @transactional
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

  # GET /transactionals/new
  # GET /transactionals/new.json
  def new
    @transactional = Transactional.new
    @parent_campaign =  params[:campaign]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @transactional }
    end
  end

  # GET /transactionals/1/edit
  def edit
    @transactional = Transactional.find(params[:id])
  end

  # POST /transactionals
  # POST /transactionals.json
  def create
    @transactional = Transactional.new(params[:transactional])
    campaign_id = params[:campaign].keys.first
    Campaign.find(campaign_id).transactional = @transactional

    respond_to do |format|
      if @transactional.save
        format.html { redirect_to @transactional, notice: "It worked. #{@test}" }
        format.json { render json: @transactional, status: :created, location: @transactional }
      else
        format.html { render action: "new" }
        format.json { render json: @transactional.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /transactionals/1
  # PUT /transactionals/1.json
  def update
    @transactional = Transactional.find(params[:id])

    respond_to do |format|
      if @transactional.update_attributes(params[:transactional])
        format.html { redirect_to @transactional, notice: 'Transactional was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @transactional.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactionals/1
  # DELETE /transactionals/1.json
  def destroy
    @transactional = Transactional.find(params[:id])
    @transactional.destroy

    respond_to do |format|
      format.html { redirect_to transactionals_url }
      format.json { head :no_content }
    end
  end
end
