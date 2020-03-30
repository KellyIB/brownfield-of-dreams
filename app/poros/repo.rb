class Repo
  attr_reader :name, :link

  def initialize(attributes)
    binding.pry
    @name = attributes[:name]
    @link = attributes[:html_url]
  end
end
