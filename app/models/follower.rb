class Follower
  attr_reader :handle, :link

  def initialize(attributes)
    @handle = attributes[:login]
    @link = attributes[:html_url]
  end

# get_follower_data(user)

end
