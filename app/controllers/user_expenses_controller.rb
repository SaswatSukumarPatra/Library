class UserExpensesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index_ungrouped
    owed = UserExpense.where(payer_id: params[:e_user_id], complete: false)
    owing = UserExpense.where(payee_id: params[:e_user_id], complete: false)

    render json: { 'You are owed': owed, 'You owe': owing }
  end

  def index
    owed = UserExpense.where(payer_id: params[:e_user_id], complete: false)
                      .group(:payee_id).pluck('SUM(amount)', 'SUM(settled)', :payee_id)
    owing = UserExpense.where(payee_id: params[:e_user_id], complete: false)
                       .group(:payer_id).pluck('SUM(amount)', 'SUM(settled)', :payer_id)

    owed_response = owed.map do |amount, settled, id|
      {
        'user': EUser.find(id).email,
        'amount': amount,
        'settled': settled
      }
    end

    owing_response = owing.map do |amount, settled, id|
      {
        'user': EUser.find(id).email,
        'amount': amount,
        'settled': settled
      }
    end

    render json: { 'You are owed': owed_response, 'You owe': owing_response }
  end

  def settle
    user_expense = UserExpense.find(params[:id])
    settled = user_expense.settled + params[:settled].to_f
    raise "Settling amount greater than expense amount" unless user_expense.amount >= settled
    complete = (user_expense.amount - settled).zero?
    user_expense.update(complete: complete, settled: settled)
  end
end
