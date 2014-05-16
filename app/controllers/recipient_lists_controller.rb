class RecipientListsController < ApplicationController
  
  def index
    @recipient_lists = RecipientList.get_recipient_lists_by_user(current_user)
    
    respond_to do |format|
      format.html 
      format.json { render json: @recipient_lists }
    end
  end

  def show
    @recipient_list = RecipientList.find(params[:id])

    respond_to do |format|
      format.html 
      format.json { render json: @recipient_list }
    end
  end
  
  def new
    @recipient_list = RecipientList.new

    respond_to do |format|
      format.html 
      format.json { render json: @recipient_list }
    end
  end
  
  def edit
    @recipient_list = RecipientList.find(params[:id])
  end

  def create
    @recipient_list = RecipientList.new(params[:recipient_list])

    respond_to do |format|
      if @recipient_list.save
        if @recipient_list.preferred? && current_user.recipient_lists.map {|list| list.preferred}.include?(true)
          @recipient_list.make_so_only_one_list_is_preferred(current_user)
        end
        current_user.recipient_lists << @recipient_list
        format.html { redirect_to @recipient_list, notice: 'Recipient list was successfully created.' }
        format.json { render json: @recipient_list, status: :created, location: @recipient_list }
      else
        format.html { render action: "new" }
        format.json { render json: @recipient_list.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @recipient_list = RecipientList.find(params[:id])

    respond_to do |format|
      if @recipient_list.update_attributes(params[:recipient_list])
        format.html { redirect_to @recipient_list, notice: 'Recipient list was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recipient_list.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipient_list = RecipientList.find(params[:id])
    @recipient_list.destroy

    respond_to do |format|
      format.html { redirect_to recipient_lists_url }
      format.json { head :no_content }
    end
  end
end
