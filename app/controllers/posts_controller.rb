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
    if @post.update_attributes(post_params)
      redirect_to post_path(@post)
    else
      render 'edit'
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
