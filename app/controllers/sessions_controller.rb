# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :check_logged_in, only: :create

  def create
    if (user = User.find_or_create_from_discord_auth(discord_auth))
      reset_session
      login user
    end
    redirect_to root_path, notice: 'ログインしました'
  end

  def destroy
    logout
    redirect_to root_path, notice: 'ログアウトしました'
  end

  private

  def discord_auth
    request.env['omniauth.auth']
  end
end
