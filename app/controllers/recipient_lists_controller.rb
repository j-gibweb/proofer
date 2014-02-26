class RecipientListsController < ApplicationController
  # GET /recipient_lists
  # GET /recipient_lists.json
  def index
    
    current_user_lists = current_user.recipient_lists
    all_users_lists = RecipientList.where("all_users = ?" , true)
    @recipient_lists  = current_user_lists | all_users_lists

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recipient_lists }
    end
  end

  # GET /recipient_lists/1
  # GET /recipient_lists/1.json
  def show
    @recipient_list = RecipientList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recipient_list }
    end
  end

  # GET /recipient_lists/new
  # GET /recipient_lists/new.json
  def new
    @recipient_list = RecipientList.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recipient_list }
    end
  end

  # GET /recipient_lists/1/edit
  def edit
    @recipient_list = RecipientList.find(params[:id])
  end

  # POST /recipient_lists
  # POST /recipient_lists.json
  def create
    @recipient_list = RecipientList.new(params[:recipient_list])

    respond_to do |format|
      if @recipient_list.save
        
        # if current_user.is_admin == true && @recipient_list.all_users == true
        #   # users = User.all 
        #   # users.each do |user| 
        #   #   user.recipient_lists << @recipient_list
        #   # end
        #   apply_to_all_users
        # else
        # end
        if current_user.recipient_lists.map {|list| list.preferred}.include?(true)
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

  # PUT /recipient_lists/1
  # PUT /recipient_lists/1.json
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

  # DELETE /recipient_lists/1
  # DELETE /recipient_lists/1.json
  def destroy
    @recipient_list = RecipientList.find(params[:id])
    @recipient_list.destroy

    respond_to do |format|
      format.html { redirect_to recipient_lists_url }
      format.json { head :no_content }
    end
  end
end
