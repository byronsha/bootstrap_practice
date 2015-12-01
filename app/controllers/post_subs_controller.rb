class PostSubsController < ApplicationController
  after_action :ensure_sub

  def ensure_sub
    @post = Post.find(params[:id])
    @post.destroy if post.subs.empty?
  end
end
