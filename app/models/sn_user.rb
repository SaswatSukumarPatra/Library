class SNUser
  include SNService
  include Comparable

  attr_reader :username, :follows

  def initialize(username)
    @username = username
    @follows = {}
  end

  def follow(username)
    @follows[username] = true
  end

  # Sort by the follow list first and then based on score
  def newsfeed
    posts = @@posts.map { |_, v| v }
    posts.sort do |a, b|
      if @follows[a.username] && !@follows[b.username]
        -1
      elsif !@follows[a.username] && @follows[b.username]
        1
      else
        a <=> b
      end
    end
  end
end
