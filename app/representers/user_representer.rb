class UserRepresenter < BaseRepresenter
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def basic
    {
      id: user.id,
      username: user.username,
      email: user.email,
      firstname: user.firstname,
      lastname: user.lastname,
    }
  end
end
