class ForeignsController < ApplicationController
  def index
    @posts = Post.where(genre: 2).order("created_at DESC").page(params[:page]).per(20)
  end
end
