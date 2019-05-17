class BMS
  def signup(username, password)
    user = User.find_by(name: username)
    raise "User #{username} exists" if user

    User.create(name: username, password: password)
  end

  def signin(username, password)
    user = User.find_by(name: username)
    raise "No user found for #{username}" unless user

    raise 'Invalid password' unless user.password == password
    user
  end

  def add_theater(theater_name)
    raise "Theater #{theater_name} exists" if Theater.find_by(name: theater_name)

    Theater.create(name: theater_name)
  end

  def add_movie(movie_name, theater_name, seats)
    theater = Theater.find_by(name: theater_name)
    raise "Movie #{movie_name} for theater #{theater_name} exists" if Movie.find_by(theater_id: theater.id, name: movie_name)

    Movie.create(name: movie_name, theater_id: theater.id, seats: seats)
  end

  def get_movie_by_theater(theater_name)
    theater = Theater.find_by(name: theater_name)

    Movie.where(theater_id: theater.id)
  end
end
