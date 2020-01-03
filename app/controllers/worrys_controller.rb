class WorrysController < ApplicationController
  def index
    @posts = Post.where(genre: 0).order("created_at DESC")
  end
end
