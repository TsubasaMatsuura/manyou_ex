class UsersController < ApplicationController
    before_action :forbid_login_user, {only: [:new, :create]}

    def index
        
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user.id)
        else
            render :new
        end
    end

    def new
        @user = User.new
    end

    def edit
    end

    def show
        @user = User.find(params[:id])

        unless @user == current_user || current_user.admin? 
            redirect_to tasks_path, notice: '他の人のページへアクセスは出来ません!'
        end
    end

    def update
    end

    def destroy
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password,
            :password_confirmation, :admin)
    end

end