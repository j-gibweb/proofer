class XslModulesController < ApplicationController
  include HtmlParser
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
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @xsl_module }
    end
  end

  def new
    @xsl_module = XslModule.new(:order => 1)
    @parent_transactional = params[:transactional]
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
    @parent = Transactional.find(params[:transactional].keys.first)
    @parent.xsl_modules << @xsl_module
    handle_xslt @xsl_module
    respond_to do |format|
      if @xsl_module.save
        format.html { redirect_to @xsl_module, notice: "#{params[:xsl]}Xsl module was successfully created." }
        format.json { render json: @xsl_module, status: :created, location: @xsl_module }
      else
        format.html { render action: "new" }
        format.json { render json: @xsl_module.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @xsl_module = XslModule.find(params[:id])
    @xsl_module.xslt = @xsl_module.generate_xslt @xsl_module
    handle_xslt @xsl_module
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
      format.html { redirect_to @xsl_module.transactional  , notice: 'Xsl module was successfully deleted.'}
      format.json { head :no_content }
    end
  end

  def handle_xslt xsl_module
    xsl_module.xslt = xsl_module.generate_xslt xsl_module
    xsl_module.xslt = go_nokogiri!(xsl_module.transactional , xsl_module.xslt , xsl_module.transactional.folder.path , "proofer-stage") if xsl_module.transactional.folder.path
  end

end
