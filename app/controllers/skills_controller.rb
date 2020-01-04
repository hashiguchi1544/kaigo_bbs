class SkillsController < ApplicationController
  def index
    @posts = Post.where(genre: 1).order("created_at DESC").page(params[:page]).per(20)
  end
end
