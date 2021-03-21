module Api::V1
  class UsersController < ApplicationController
    before_action :authorize_request, except: :create
    before_action :find_user, only: %i[show update destroy]

    def index
      @users = User.all
      render json: @users, status: :ok
    end

    def show
      render json: @user, status: :ok
    end

    def create
      @user = User.new(user_params)
      if @user.save
        render json: { user: @user }, status: :created
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessible_entity
      end
    end

    def update
      return if @user.update(user_params)

      render json: { errors: @user.errors.full_messages }, status: :unprocessible_entity
    end

    def destroy
      @user.destroy
    end

    private

    def find_user
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
    end

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
  end
end
