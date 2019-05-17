module SNService
  @@users = {}
  @@user_posts = {}
  @@logged_user = nil
  @@posts = {}

  def self.users
    @@users
  end

  def self.user_posts
    @@user_posts
  end

  def self.logged_user
    @@logged_user
  end

  def self.logged_user=(user)
    @@logged_user = user
  end

  def self.posts
    @@posts
  end

  class Service
    include SNService
    def signup(username)
      user = @@users[username]
      raise 'Sorry this username is taken' if user

      @@users[username] = SNUser.new(username)
    end

    def login(username)
      raise "Invalid user #{username}. Please signup" unless @@users[username]

      @@logged_user = @@users[username]
      @@logged_user.newsfeed
    end

    def post(post_message)
      raise 'Login please' unless @@logged_user
      username = @@logged_user.username
      post = SNPost.new(username, post_message)
      @@user_posts[username] = post
      @@posts[post.id] = post
    end

    def upvote(post_id)
      raise 'Login please' unless @@logged_user

      post = @@posts[post_id]
      post.upvote
      @@user_posts[post.username] = post
      @@posts[post.id] = post
    end

    def downvote(post_id)
      raise 'Login please' unless @@logged_user

      post = @@posts[post_id]
      post.downvote
      @@user_posts[post.username] = post
      @@posts[post.id] = post
    end

    def comment(post_id, comment)
      raise 'Login please' unless @@logged_user

      post = @@posts[post_id]
      post.comment(SNPost.new(@logged_user.username, comment))
      @@user_posts[post.username] = post
      @@posts[post.id] = post
    end

    def posts
      raise 'Login please' unless @@logged_user

      @@logged_user.newsfeed
    end

    def follow(username)
      raise 'Login please' unless @@logged_user

      @@logged_user.follow(username)
      @@users[@@logged_user.username] = @@logged_user
    end

    def logout
      @@logged_user = nil
    end
  end
end
