class UsersRepresenter
  def initialize(users)
    @users = users
  end

  def as_json(_ = {})
    @users.map do |user|
      UserRepresenter.new(user)
    end
  end
end
