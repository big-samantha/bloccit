class FavoriteMailer < ActionMailer::Base
  default from: "zacharyalexstern@gmail.com"

  def new_comment(user, post, comment)

    # New Headers
    headers["Message-ID"] = "<comments/#{comment.id}@bloccit-zacharyalexstern.herokuapp.com>"
    headers["In-Reply-To"] = "<post/#{post.id}@bloccit-zacharyalexstern.herokuapp.com>"
    headers["References"] = "<post/#{post.id}@bloccit-zacharyalexstern.herokuapp.com>"

    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end
