class GithubUser
  attr_reader :email, :name

  def initialize(attributes)
    @email = attributes[:email]
    @name = attributes[:name]
  end
end
