class UsersRepresenter < BaseRepresenter
  def initialize(users)
    @users = users
  end

  def basic
    @users.map do |user|
      UserRepresenter.new(user).basic
    end
  end
end
