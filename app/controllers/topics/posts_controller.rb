class Topics::PostsController < ApplicationController
  def post_params
    params.require(:post).permit(:title, :body, :postimage)
  end

  def show
    # find post from topic to fix bug
    @post = Post.find(params[:id])
    @topic = Topic.find(params[:topic_id])
    authorize @topic
    @comments = @post.comments
    @comment = Comment.new
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    authorize @post
  end

  def create
    # Non-user-associated posts.
    # @post = Post.new(params.require(:post).permit(:title,:body))

    @topic = Topic.find(params[:topic_id])
    @post = current_user.posts.new(post_params)
    @post.topic = @topic

    authorize @post
    if @post.save
      @post.create_vote
      flash[:notice] = 'Post was saved.'
      redirect_to [@topic, @post]
    else
      flash[:error] = 'There was an error saving the post. Please try again.'
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
    if @post.update_attributes(post_params)
      flash[:notice] = "Post was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])

    title = @post.title
    authorize @post
    
    if @post.destroy
      flash[:notice] = "\"#{title}\" was deleted successfully."
      redirect_to @topic
    else
      flash[:notice] = 'There was an error deleting the post.'
      render :show
    end
  end
end
