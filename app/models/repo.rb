class Repo
  def initialize(attributes)
    @name = attributes[:name]
    @link = attributes[:html_url]
  end
end
