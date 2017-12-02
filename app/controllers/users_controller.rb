class UsersController < ApplicationController
  before_filter :authorize_admin, only: :create
  
  def index
    @users = User.all
  end
  
  def show
    @customer = Customer.find(params[:customer_id])
    @user = User.find_by(id: params[:id])
    if @user.nil?
      redirect_to action: :index
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def new
    #1st you retrieve the customer thanks to params[:customer_id]
    @customer = Customer.find(params[:customer_id])
    #2nd you build a new one
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    #retrieve the site thanks to params[:id]
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update(user_params)
        #1st argument of redirect_to is an array, in order to build the correct route to the nested resource site
        format.html { redirect_to([@user], :notice => 'Site was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    # retrieve the site thanks to params[:id]
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end

  private

  # This should probably be abstracted to ApplicationController
  # as shown by diego.greyrobot
  def authorize_admin
    return unless !current_user.admin?
    redirect_to root_path, alert: 'Admins only!'
  end
  
    def set_user
      @user = @customer.find(params[:id]).users
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, customers_attributes: [:name, :id])
    end
    
    def set_customer
      @customer = Customer.find(params[:customer_id])
    end
end