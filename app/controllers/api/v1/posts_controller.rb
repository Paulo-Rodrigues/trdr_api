module Api::V1
  class PostsController < ApplicationController
    before_action :authorize_request

    def show
      @post = Post.find(params[:id])
      render @post, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'not found' }, status: :not_found
    end

    def create
      @post = Post.new(post_params)
      @post.user = @current_user
      if @post.save
        render json: @post, status: :created
      else
        render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      @post = Post.find(params[:id])
      @post.destroy
      render json: { success: 'Post deleted' }, status: :ok
    end

    private

    def post_params
      params.require(:post).permit(:body)
    end
  end
end
