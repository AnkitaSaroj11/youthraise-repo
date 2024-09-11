class LoginsController < ApplicationController
  skip_before_action :current_user_required
  before_action :redirect_if_authenticated

  def new
    @login = Login.new
    @email_signup = params[:email_signup]
  end

  def create
    @login = Login.new(login_params)
    if @login.save
      if @login.user
        if login_params[:mobile]
          @login.send_confirmation_code_text
        else
          LoginsMailer.with(login: @login).login_attempt.deliver_now
        end
      end
      redirect_to edit_login_path(@login.uuid)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @login = Login.active.find_by(uuid: params[:id])
  end

  def update
    @login = Login.active.find_by(uuid: params[:id])
    if @login.user && @login.confirmation_code == params[:login][:confirmation_code_attempt]
      login(@login.user)
      redirect_to landing_page_path
    else
      redirect_to new_login_path, notice: "Your credentials could not be verified"
    end
  end

  private

  def login_params
    params.require(:login).permit(:email, :mobile)
  end
end
