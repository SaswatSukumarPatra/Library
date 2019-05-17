class UserExpense < ApplicationRecord
  belongs_to :expense
  belongs_to :payer, class_name: 'EUser', foreign_key: 'payer_id'
  belongs_to :payee, class_name: 'EUser', foreign_key: 'payee_id'

  def remaining_amount
    amount.to_f - settled.to_f
  end
end
