class CampaignsController < ApplicationController
  def index
    if current_user
      @campaigns = current_user.campaigns.most_recent
    else
      @campaigns = []
    end
    respond_to do |format|
      format.html 
      format.json { render json: @campaigns }
    end
  end

  def show
    @campaign = Campaign.find(params[:id])
    respond_to do |format|
      format.html 
      format.json { render json: @campaign }
    end
  end

  def new
    @campaign = Campaign.new    
    respond_to do |format|
      format.html 
      format.json { render json: @campaign }
    end
  end

  def edit
    @campaign = Campaign.find(params[:id])
  end

  def create
    @campaign = Campaign.new(params[:campaign])    
    respond_to do |format|
      if @campaign.save
        current_user.campaigns << @campaign
        format.html { redirect_to @campaign, notice: "Campaign was successfully created" }
        format.json { render json: @campaign, status: :created, location: @campaign }
      else
        format.html { render action: "new" }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @campaign = Campaign.find(params[:id])
    respond_to do |format|
      if @campaign.update_attributes(params[:campaign])
        format.html { redirect_to @campaign, notice: 'Campaign was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @campaign = Campaign.find(params[:id])
    @campaign.emails.each do |email|
      email.destroy
    end
    if @campaign.transactional
      @campaign.transactional.xsl_modules.each {|x| x.destroy } 
      @campaign.transactional.destroy 
    end
    @campaign.destroy

    respond_to do |format|
      format.html { redirect_to campaigns_url }
      format.json { head :no_content }
    end
  end
end
