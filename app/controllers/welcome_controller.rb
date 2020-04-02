class WelcomeController < ApplicationController
  def index
    @tutorials = filtered_videos
    @tutorials = if params[:tag]
                   @tutorials.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
                 else
                   @tutorials.paginate(page: params[:page], per_page: 5)
                 end
  end

  private

  def filtered_videos
    if current_user
      Tutorial.all
    else
      Tutorial.where(classroom: false)
    end
  end
end
