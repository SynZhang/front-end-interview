class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

  def show
  end

  def index
  end

  def create
  end

  def edit
  end

  def update
    case params[:event]
    when 'archive'
      if @post.archive
        response_to do |format|
          format.json { head :no_content }
        end
      else
        response_to do |format|
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    when 'vote'
      if current_user.vote(@post)
        response_to do |format|
          format.json { head :no_content }
        end
      else
        response_to do |format|
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    when 'share'
      if current_user.share(@post)
        response_to do |format|
          format.json { head :no_content }
        end
      else
        response_to do |format|
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    else
      if @post.update_attributes(post_params)
        redirect_to post_path(@post)
      else
        render 'edit'
      end
    end
  end

  private

  def post_params
    params.require(:post).permit!
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
