class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    if comment.save
      redirect_to "/posts/#{comment.post.id}",  notice: 'コメントを投稿しました。'
    else
      redirect_to "/posts/#{comment.post.id}",  notice: 'コメントを投稿できませんでした'
    end
  end

  def destroy
    comment = Comment.find(params[:post_id])
    comment.destroy
    redirect_to "/posts/#{comment.post.id}",  notice: 'コメントを削除しました。'
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
