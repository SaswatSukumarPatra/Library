class SNPost
  include SNService
  include Comparable

  attr_reader :message, :username, :score, :comments, :time, :id
  attr_writer :score

  def initialize(username, post_message)
    @username = username
    @message = post_message
    @score = 0
    @comments = []
    @time = Time.now
    @id = username + Time.now.to_i.to_s
  end

  def upvote
    @score = @score.to_i + 1
  end

  def downvote
    @score = @score.to_i - 1
  end

  def comment(comment)
    @comments.append(comment)
  end

  def <=>(other)
    score_comp = @score <=> other.score
    comment_comp = @comments.size <=> other.comments.size
    time_comp = @time <=> other.time

    if score_comp != 0
      return score_comp * -1
    elsif comment_comp != 0
      return comment_comp * -1
    else
      return time_comp * -1
    end
  end
end
