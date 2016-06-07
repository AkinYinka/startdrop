class Api::V1::UsersController < Api::V1::BaseController
  

  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
  	user = User.new(create_params)
    return api_error(status: 422, errors: user.errors.full_messages) unless user.valid?

    user.save!
    render(
          json: user,
          status: 201,
          location: api_v1_user_path(user.id)
    )
  end

  def update
  	user = User.find(params[:id])
    if !user.update_attributes(update_params)
      return api_error(status: 422, errors: user.errors.full_messages)
    end

    render(
      json: user,
      status: 200,
      location: api_v1_user_path(user.id),
      serializer: Api::V1::UserSerializer
    )
  end

  def destroy
    user = User.find(params[:id])

    if !user.destroy
      return api_error(status: 500)
    end

    head status: 204
  end

  private

  def create_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :name
    ).delete_if{ |k,v| v.nil?}
  end

  def update_params
    create_params
  end
end