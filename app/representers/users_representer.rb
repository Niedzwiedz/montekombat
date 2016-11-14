class UsersRepresenter < BaseRepresenter
  attr_reader :users

  def initialize(users)
    @users = users
  end

  def basic
    users.map do |user|
      UserRepresenter.new(user).basic
    end
  end
end
