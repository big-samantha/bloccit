class CommentsController < ApplicationController
  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end
  
  def create
    @comment = current_user.comments.new(comment_params)
    @post = Post.find_by(id: params[:post_id])
    @comment.post = @post
    if @comment.save
      redirect_to [@post.topic, @post], notice: "Comment was saved successfully."
    else
      flash[:error] = 'Error creating comment. Please try again.'
      redirect_to [@post.topic, @post]
    end
  end

  def destroy
    @post = Post.find_by(id: params[:post_id])
    @comment = @post.comments.find(params[:id])

    authorize @comment

    if @comment.destroy
      flash[:notice] = "Comment was removed."
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "Comment couldn't be deleted. Try again."
      redirect_to [@post.topic, @post]
    end
  end
end
