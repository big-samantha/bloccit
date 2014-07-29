class FavoritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post: @post)

    authorize favorite
    if favorite.save
      flash[:notice] = 'Favorited!'
      redirect_to [@post.topic, @post]
    else
      flash[:error] = 'There was a problem favoriting this post.'
      redirect_to [@post.topic, @post]
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post.id)

    authorize favorite
    if favorite.destroy
      flash[:notice] = "Post unfavorited!"
      redirect_to [@post.topic, @post]
    else
      flash[:error] = 'There was a problem unfavoriting this post.'
      redirect_to [@post.topic, @post]
    end
  end
end
