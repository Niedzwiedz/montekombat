class UsersRepresenter < BaseRepresenter
  def initialize(users)
    @users = users
  end

  def basic
    @users.map do |user|
      {
        id: user.id,
        username: user.username,
        email: user.email,
        firstname: user.firstname,
        lastname: user.lastname,
      }
    end
  end
end
