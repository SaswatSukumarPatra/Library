class EUser < ApplicationRecord
  has_many :user_expenses
  has_many :expenses
end
