require 'rails_helper'
require 'faker'

describe Post do
  describe "vote methods" do

    before do

      @user = User.new(
        name:     Faker::Name.name,
        email:    Faker::Internet.email,
        password: Faker::Lorem.characters(10)
      )
      @user.skip_confirmation!
      @user.save

      @topic = Topic.create(
        name:         Faker::Lorem.sentence,
        description:  Faker::Lorem.paragraph
      )
      @post = Post.create(title: 'post title', body: 'Post bodies must be pretty long.', topic_id: 1, user_id: 1)#, topic: Topic.first, user: User.first)


      3.times { @post.votes.create(value: 1) }
      2.times { @post.votes.create(value: -1) }
    end

    describe 'post is valid' do
      it 'validates' do
        expect(@post.valid?).to eq(true)
      end
    end

    describe '#up_votes' do
      it "counts the number of votes with value = 1" do
        expect( @post.up_votes).to eq(4)
      end
    end

    describe '#down_votes' do
      it "counts the number of votes with value = -1" do
        expect( @post.down_votes).to eq(2)
      end
    end

    describe '#points' do
      it 'returns the sum of all down and up votes' do
        expect( @post.points ).to eq(2) # 4 - 2
      end
    end
  end
end
