class Expense < ApplicationRecord
  has_many :user_expenses
  belongs_to :e_user
end
