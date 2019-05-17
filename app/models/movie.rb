class Movie < ApplicationRecord
  has_many :booking, dependent: :destroy
end
