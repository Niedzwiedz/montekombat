class UserRepresenter
  def initialize(user)
    @user = user
  end

  def as_json(_ = {})
    {
      id: @user.id,
      username: @user.username,
      email: @user.email,
      firstname: @user.firstname,
      lastname: @user.lastname,
    }
  end
end
