class Repo
  attr_reader :name, :link

  def initialize(attributes)
    @name = attributes[:name]
    @link = attributes[:html_url]
  end

end
