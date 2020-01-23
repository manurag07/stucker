# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard]
  def home
    redirect_to dashboard_path if current_user
  end

  def dashboard
    @scheduled = current_user.posts.where(state: 'scheduled')
                             .paginate(page: params[:scheduled_page], per_page: 4)
                             .order('scheduled_at ASC')
    @history = current_user.posts.where.not(state: 'scheduled')
                           .paginate(page: params[:history_page], per_page: 4)
                           .order('scheduled_at DESC')
  end
end
