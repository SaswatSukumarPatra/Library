class User < ApplicationRecord
  has_many :bookings, dependent: :destroy

  def book(movie_name, theater_name, seats)
    theater = Theater.find_by(name: theater_name)
    movie = Movie.find_by(name: movie_name, theater_id: theater.id)

    movie.with_lock do
      seats.each do |seat|
        raise 'Seats taken please retry' if movie.seats[seat] == 1
        movie.seats[seat] = 1
      end
      movie.save!

      Booking.create(movie_id: movie.id, user_id: id, seats: seats)
    end
  end

  def bookings
    Booking.where(user_id: id)
  end
end
