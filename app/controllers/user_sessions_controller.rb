class UserSessionsController < ApplicationController
  def destroy
    logout
    redirect_to root_path, notice: "Logged out successfully"
  end
end