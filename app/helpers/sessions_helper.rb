module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def login_check
    redirect_to new_session_path unless logged_in?
  end

  def require_login
      redirect_to new_user_path unless current_user
    end

    def forbid_login_user
      redirect_to tasks_path, notice: 'すでにログインしています' if current_user
    end
end
