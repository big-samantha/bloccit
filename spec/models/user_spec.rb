require 'rails_helper'

describe User do

  include TestFactories

  before do
    @post = post_without_user
    @user = authenticated_user
  end
    #@fave = Fave.new(user_id: @user.id, 

  describe "#favorited(post)" do
    it "returns `nil` if the user has not favorited the post" do
      @user.favorited(@post)
    end

    it "returns the appropriate favorite if it exists" do
      fav = Favorite.new(post_id: @post.id, user_id: @user.id)
      fav.save
      returnedfav = @user.favorited(@post)
      expect((returnedfav).user).to eq(@user)
      expect((returnedfav).post).to eq(@post)
      expect(@user.favorited(@post)).to be_a Favorite
    end
  end
end
