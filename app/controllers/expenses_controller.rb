class ExpensesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    ActiveRecord::Base.transaction do
      expense = Expense.create(create_params)
      create_user_expenses(expense.id)
    end
  rescue => error
    render json: error
  end

  def index
    result = Expense.where(e_user_id: params[:e_user_id].to_i).map do |expense|
      user_expenses = UserExpense.where(expense_id: expense.id)
      {
        'name': expense.name,
        'original_amount': expense.amount,
        'payer': EUser.find_by(expense.e_user_id).email,
        'user_expenses': user_expenses
      }
    end
    render json: result
  end

  private

  def create_params
    @create_params ||= {
      name: params[:name],
      split_type: params[:split_type],
      amount: params[:amount],
      e_user_id: params[:e_user_id]
    }
  end

  def create_user_expenses(expense_id)
    case create_params[:split_type]
    when 'percentage'
      create_percentage_user_expenses(expense_id)
    when 'exact'
      create_exact_user_expenses(expense_id)
    else
      raise "Invalid split type #{create_params[:split_type]}"
    end
  end

  def create_percentage_user_expenses(expense_id)
    total = 0
    params[:split].each do |email, value|
      if value <= 0 || value > 100 || (total + value) > 100
        raise 'The percentages do not add up'
      end
      amount = create_params[:amount] * value / 100
      create_user_expense(email, amount, expense_id)
      total += value
    end
  end

  def create_exact_user_expenses(expense_id)
    total = 0
    params[:split].each do |email, value|
      if value <= 0 || (total + value) > create_params[:amount]
        raise 'The values do not add up'
      end
      create_user_expense(email, value, expense_id)
      total += value
    end
  end

  def create_user_expense(email, value, expense_id)
    user = EUser.find_by(email: email)
    raise "Invalid user with #{email}" unless user
    if user.id != create_params[:e_user_id].to_i
      payload = {
        amount: value,
        settled: 0.to_f,
        payer_id: create_params[:e_user_id],
        payee_id: user.id,
        complete: false,
        expense_id: expense_id
      }
      UserExpense.create(payload)
    end
  end
end
