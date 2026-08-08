# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @videos = @user.videos.order(created_at: :desc)
  end
end
