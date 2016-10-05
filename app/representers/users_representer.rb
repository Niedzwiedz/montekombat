class UsersRepresenter
  def initialize(users)
    @users = users
  end

  def as_json(_ = {})
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
