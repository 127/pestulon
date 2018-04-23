# TODO select roles for user
class Admin::UsersController < Admin::AdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.order(:created_at).reverse_order.page(params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
         if @user.save
           @user.confirm
           format.html { redirect_to [:admin, @user], notice: 'Document was successfully created.' }
           format.json { render action: 'show', status: :created, location: @user }
         else
           format.html { render action: 'new' }
           format.json { render json: @user.errors, status: :unprocessable_entity }
         end
       end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        @user.confirm
        format.html { redirect_to [:admin, @user], notice: 'Document was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

    # DELETE /users/1
    # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url }
      format.json { head :no_content }
    end
  end

  private
    
    def set_user 
      @user = User.find(params[:id])
    end
    
    def check_role
      @admin = false
      current_user.roles.each do |role|
        if role.name.to_s == 'admin'
          @admin = true 
          break
        end
      end
      render 'shared/prohibited' if @admin == false
    end
    
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :account_id)
    end

end
