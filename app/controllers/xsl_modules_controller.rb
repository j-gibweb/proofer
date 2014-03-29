class XslModulesController < ApplicationController

  def index
    @xsl_modules = XslModule.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @xsl_modules }
    end
  end

  def show
    @xsl_module = XslModule.find(params[:id])
    @parent_campaign = Campaign.find(@xsl_module.transactional.campaign_id)
    @doc = Nokogiri::XML(@xsl_module.transactional.xml)
    @xslt  = Nokogiri::XSLT(@xsl_module.xsl) 
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @xsl_module }
    end
  end

  def new
    @xsl_module = XslModule.new
    # DONT USE SESSION
    session[:transactional] = params[:transactional]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @xsl_module }
    end
  end

  def edit
    @xsl_module = XslModule.find(params[:id])
  end

  def create
    @xsl_module = XslModule.new(params[:xsl_module])
    # DONT USE SESSION
    add_xsl_module_to_transactional_children @xsl_module
    generate_xslt @xsl_module

    respond_to do |format|
      if @xsl_module.save
        format.html { redirect_to @xsl_module, notice: 'Xsl module was successfully created.' }
        format.json { render json: @xsl_module, status: :created, location: @xsl_module }
      else
        format.html { render action: "new" }
        format.json { render json: @xsl_module.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_xsl_module_to_transactional_children xsl_module
    Transactional.find(session[:transactional]).xsl_modules << xsl_module
  end

  def generate_xslt xsl_module
    @xsl_module = xsl_module
    @doc = Nokogiri::XML(xsl_module.transactional.xml)
    @xslt  = Nokogiri::XSLT(xsl_module.xsl)
    @xsl_module.xslt = @xslt.transform(@doc).to_xml 
  end

  def update
    @xsl_module = XslModule.find(params[:id])

    respond_to do |format|
      if @xsl_module.update_attributes(params[:xsl_module])
        format.html { redirect_to @xsl_module, notice: 'Xsl module was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @xsl_module.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @xsl_module = XslModule.find(params[:id])
    @xsl_module.destroy

    respond_to do |format|
      format.html { redirect_to xsl_modules_url }
      format.json { head :no_content }
    end
  end
end
