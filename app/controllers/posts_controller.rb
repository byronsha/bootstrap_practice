class PostsController < ApplicationController
  before_action :ensure_author, only: [:edit, :update, :destroy]
  before_action :ensure_logged_in

  def new
    @post = Post.new
    @sub_id = params[:sub_id].to_i
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      redirect_to sub_url([params[:sub_id]])
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def index
    @posts = Post.all
  end

  def edit
    @post = Post.find(params[:id])

  end

  def update
    @post = Post.find(params[:id])
    if params[:post][:sub_ids] == [""]
      @post.destroy
      redirect_to subs_url
    elsif @post.update(post_params)
      redirect_to sub_url(@post.subs.find(params[:sub_id]))
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy!
    redirect_to Sub.find(params[:sub_id])
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

  def ensure_author
    post = Post.find(params[:id])
    unless current_user.id == post.author_id
      flash[:errors] = "YOU ARE NOT THE AUTHOR"
      redirect_to sub_post_url(post.sub, post)
    end
  end

end
