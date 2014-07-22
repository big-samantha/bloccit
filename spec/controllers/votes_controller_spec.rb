require 'rails_helper'

describe VotesController do
  
  include TestFactories
  include Devise::TestHelpers

  describe '#up_vote' do
    it "adds an up-vote to the post" do
      request.env["HTTP_REFERER"] = '/'
      @user = authenticated_user
      @post = post_without_user
      sign_in @user

      expect {
        post( :up_vote, post_id: @post.id )
      }.to change{ @post.up_votes }.by 1
    end
  end
end
