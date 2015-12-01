class SubsController < ApplicationController
  before_action :ensure_moderator, only: [:edit, :update, :destroy]
  before_action :ensure_logged_in

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    # @sub = current_user.subs.new(sub_params)

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def index
    @subs = Sub.all
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def ensure_moderator
    ssub = Sub.find(params[:id])
    unless current_user.id == ssub.moderator_id
      flash[:errors] = "YOU ARE NOT A MODERATOR"
      redirect_to subs_url
    end
  end
end
