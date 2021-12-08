class BudgetsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def show
    @budget = Budget.find(params[:id])
  end

  def new
    @budget = Budget.new
    @participants = User.all
  end

  def create
    @budget = Budget.new(budget_params)
    @budget.total_cents = 0
    @budget.save!
    selected_users = params[:budget][:participants][1...10] # ==> je recupere les clés sous forme d'array ["1", "2"]

    selected_users.each do |user|
    user1 = UserBudget.create(budget_id: @budget.id, user_id: user.to_i)
    user1.save!
    end

    if @budget.save!
      redirect_to root_path
    else
      @participants = User.all
      render :new
    end

  end

  private

  def budget_params
    params.require(:budget).permit(:name, :total_cents, :balance_cents)
  end
end
