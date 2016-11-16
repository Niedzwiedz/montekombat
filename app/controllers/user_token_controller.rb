class UserTokenController < Knock::AuthTokenController
  def create
    render json: { user_token: JSON.parse(auth_token.to_json), user: UserRepresenter.new(entity) },
               status: :created
  end
end
