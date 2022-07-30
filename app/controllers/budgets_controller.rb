class BudgetsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def show
    @budget = Budget.find(params[:id])
    @payments = Payment.where(budget_id: @budget.id)
  end

  def index
    @budgets = Budget.all
  end

  def new
    @budget = Budget.new
    @participants = User.where.not(id: current_user.id)
  end

  def edit
    @budget = Budget.find(params[:id])
    @participants = @budget.users
  end

  def update
    @budget = Budget.find(params[:id])
    @budget.update(budget_params)
    redirect_to root_path
  end

  def create
    params[:budget][:name].capitalize!
    @budget = Budget.new(budget_params)
    @budget.total_cents = 0
    @budget.save
    selected_users = params[:budget][:participants][1...10] # ==> je recupere les ids sous forme d'array ["1", "2"]
    selected_users.push(current_user.id) # ===> on push current_user dans les selected users

    selected_users.each do |user|
      UserBudget.create(budget_id: @budget.id, user_id: user.to_i)
    end

    if @budget.save
      redirect_to root_path
    else
      @participants = User.all
      render :new
    end
  end

  def destroy
    @budget = Budget.find(params[:id])
    @budget.destroy
    redirect_to root_path
  end

  def reinit
    @budget = Budget.find(params[:id])
    @persons = []
    UserBudget.where(budget_id: @budget.id).each do |userbudget|
      userbudget.dette = 0
      userbudget.save
    end
    redirect_to budget_path(@budget)
  end

  private

  def budget_params
    params.require(:budget).permit(:name, :total_cents, :balance_cents)
  end
end
