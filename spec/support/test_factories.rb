module TestFactories
  def post_without_user
    post = Post.new(title: 'Post title', body: 'Post bodies must be pretty long.')
    allow(post).to receive(:create_vote)
    post.save
    post
  end

  def authenticated_user
    email = "email#{rand}@fake.com"
    user = User.new(email: email, password: 'password' )
    user.skip_confirmation!
    user.save
    user
  end
end
