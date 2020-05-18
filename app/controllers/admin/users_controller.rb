class Admin::UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    #before_action :require_login

    def index
      @users = User.all
      unless current_user.admin?
        redirect_to user_path(current_user), notice: '管理者権限ページへアクセスは出来ません!'
      end
    end

    def create
        @user = User.new(user_params)
        if @user.save
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
      @tasks = @user.tasks
    
    end

    def update
      @user.update(user_params)
      if User.where(admin: :true).count == 0
        @user.update(admin: :true)
        redirect_to admin_users_path
        flash[:warning] = "管理者は編集できました"
      elsif @user.save == false
        flash[:danger] = "管理者は１名以下なので編集できませんでした"
        render :edit
      elsif User.where(admin: :true).count >= 1
        redirect_to admin_users_path
        flash[:info] = "ユーザー詳細を編集しました！"
      end
 
    end

    def destroy
      
      if @user.destroy
        redirect_to admin_users_path, notice: 'ユーザーは削除されました。'
      else
        redirect_to admin_users_path, notice: 'ユーザーは削除出来ませんでした'
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:name, :email, :password,
            :password_confirmation, :admin)
    end
end