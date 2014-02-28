class PromotionalsController < ApplicationController
  
  def index
    @promotionals = Promotional.all

    respond_to do |format|
      format.html 
      format.json { render json: @promotionals }
    end
  end
  
  def show
    @promotional = Promotional.find(params[:id])

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

    respond_to do |format|
      if @promotional.save
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

    respond_to do |format|
      if @promotional.update_attributes(params[:promotional])
        format.html { redirect_to @promotional, notice: 'Promotional was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @promotional.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @promotional = Promotional.find(params[:id])
    @promotional.destroy

    respond_to do |format|
      format.html { redirect_to promotionals_url }
      format.json { head :no_content }
    end
  end
end
