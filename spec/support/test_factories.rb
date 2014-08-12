module TestFactories
  def post_without_user(options={})
    post_options = { title: 'Post title', body: 'Post bodies must be pretty long.' }.merge(options)
    post = Post.new(post_options)
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

  def associated_post(options={})
    post_options = {
      title: 'Post title',
      body: 'Post bodies must be pretty long.',
      topic: Topic.create(name: 'Topic name'),
      user: authenticated_user
    }.merge(options)

    Post.create(post_options)
  end
end
