class Follower
  attr_reader :handle, :link, :id

  def initialize(attributes)
    @handle = attributes[:login]
    @link = attributes[:html_url]
    @id = attributes[:id]
  end

  def registered?
    @id && User.exists?(github_id: @id)
  end

end
