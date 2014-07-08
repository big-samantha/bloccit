class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment.post = @post
    if @comment.save
      redirect_to [@topic, @post], notice: "Comment was saved successfully."
    else
      flash[:error] = 'Error creating comment. Please try again.'
      redirect_to [@topic, @post]
    end
  end

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end
end
