class Api::ListsController < ApiController

  before_action :authenticated?

  def create

    list = List.new(list_params)
    list.user_id = params[:user_id]

    if list.save
      render json: list
    else
      render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
    end

  end


  def update
    list = List.find(params[:id])

    if list.update(list_params)
      render json: list
    else
      render json: { errors: list.errors.full_messages }, status: :unprocessable_entity

    end
  end

  def destroy

    user = User.find(params[:user_id])

    begin
      list = List.find(params[:id])
      list.destroy

      render json: {}, status: :no_content, :message => "Successful deletion of #{user.full_name}"

    rescue ActiveRecord::RecordNotFound

      render :json => {}, :status => :not_found
    end

  end


  private

  def list_params
    params.require(:list).permit(:name, :permissions)
  end
end
