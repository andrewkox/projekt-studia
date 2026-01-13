class SessionsController < ApplicationController
  def new
  end

  def create
    admin = Admin.find_by(email: params[:email])

    if admin&.authenticate(params[:password])
      session[:admin_id] = admin.id
      redirect_to root_path, notice: "Zalogowano"
    else
      flash.now[:alert] = "Błędny email lub hasło"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:admin_id] = nil
    redirect_to login_path, notice: "Wylogowano"
  end
end
