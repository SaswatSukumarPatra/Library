class Theater < ApplicationRecord
  has_many :movie, dependent: :destroy
end
