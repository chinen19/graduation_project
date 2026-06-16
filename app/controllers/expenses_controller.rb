class ExpensesController < ApplicationController
  before_action :require_login  # ログインが必要
  
  def index
    @expenses = current_user.expenses.includes(:category).order(date: :desc)
  end
end