class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    #@user = User.new(params[:user])
    # Activation based on http://github.com/matthooks/authlogic-activation-tutorial/
    @user = User.new
    if @user.signup!(params)
      @user.deliver_activation_instructions!
      flash[:notice] = "Your account has been created. Please check your e-mail for your account activation instructions!"
      redirect_to root_url
    # without activation
    #if @user.save
    #  flash[:notice] = "Registration successful."
    #  redirect_back_or_default account_url
    else
      render :action => :new
    end
  end
  
  def edit
    @user = @current_user
  end
  
  def show
    @user = @current_user
  end
  
  def update
    @user = @current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated profile."
      redirect_to account_url
    else
      render :action => :edit
    end
  end
  
end
