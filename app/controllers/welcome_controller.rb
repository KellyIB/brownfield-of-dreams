class WelcomeController < ApplicationController
  def index
    @tutorials = filtered_videos
    if params[:tag]
      @tutorials = @tutorials.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 5)
    else
      @tutorials = @tutorials.paginate(:page => params[:page], :per_page => 5)
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
