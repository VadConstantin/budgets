class PaymentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def index
  @payments = Payment.all
  end

  def new
    @budget = Budget.find(params[:budget_id])
    @payment = Payment.new
    @participants = @budget.users
  end

  def edit
    @budget = Budget.find(params[:id])
    @payment = Payment.find(params[:payment_id])
    @participants = @budget.users
    @payeurs_edit = [UserPayment.where(payment_id: @payment.id).where(state: "payeur")[0].user]
  end

  def update

    # on efface la dette du payeur et l'incrementation du total du budget

    @budget = Budget.find(params[:budget_id])
    @payment = Payment.find(params[:id])

    @payeur = UserPayment.where(payment_id: @payment.id).where(state: "payeur")[0].user_id
    @user_budget_payeur = UserBudget.where(budget_id: @budget.id).where(user_id: @payeur.to_i)

    @receveurs = []
    UserPayment.where(payment_id: @payment.id).where(state: "receveur").each do |user_payment|
    @receveurs << user_payment.user_id
    end

    if @receveurs.length == 1 && @receveurs[0] == @payeur
        @user_budget_payeur[0].dette += 0
      elsif @receveurs.include?(@payeur)
        @user_budget_payeur[0].dette -= @payment.montant_cents.to_f.fdiv(@receveurs.length)
        @user_budget_payeur[0].save
      elsif @receveurs.include?(@payeur) == false
        @user_budget_payeur[0].dette -= @payment.montant_cents.to_i
        @user_budget_payeur[0].save
    end

    @budget.total_cents -= @payment.montant_cents
    @budget.save
    @payment.destroy

    # on met à jour la dette du payeur et on incremente le total du budget

    return create

  end

  def create

    @budget = Budget.find(params[:budget_id])
    params[:payment][:commentaire].capitalize!

    @payment = Payment.new(payment_params)
    @payment.budget_id = @budget.id
    if @payment.save

      # ------------------PAYEUR---------------------

      @payeur = params[:payment][:payeurs] #=> "1"
      u = UserPayment.create(payment_id: @payment.id, user_id: @payeur.to_i, state: "payeur")
      u.save!

      # ----------------RECEVEUR(S)------------------

      @receveurs = params[:payment][:receveurs][1...10] #=> ["1", "3"]
      @receveurs.each do |receveur|
        v = UserPayment.create(payment_id: @payment.id, user_id: receveur.to_i, state: "receveur")
        v.save!
      end

      # ------------------BALANCE--------------------
      @user_budget_payeur = UserBudget.where(budget_id: @budget.id).where(user_id: @payeur.to_i)
      if @receveurs.length == 1 && @receveurs[0] == @payeur
        @user_budget_payeur[0].dette += 0
      elsif @receveurs.include?(@payeur)
        @user_budget_payeur[0].dette += (params[:payment][:montant_cents]).to_f.fdiv(@receveurs.length)
        @user_budget_payeur[0].save
      elsif @receveurs.include?(@payeur) == false
        @user_budget_payeur[0].dette += params[:payment][:montant_cents].to_i
        @user_budget_payeur[0].save
      end

    else
      @participants = @budget.users
      render :new
    end

     # ------------------TOTAL----------------------
    @budget.total_cents += params[:payment][:montant_cents].to_i
    @budget.save

    if @payment.save
      redirect_to budget_path(@budget)
    end

  end


  def destroy
    @budget = Budget.find(params[:id])
    @payment = Payment.find(params[:payment_id])

    @payeur = UserPayment.where(payment_id: @payment.id).where(state: "payeur")[0].user_id
    @user_budget_payeur = UserBudget.where(budget_id: @budget.id).where(user_id: @payeur.to_i)

    @receveurs = []
    UserPayment.where(payment_id: @payment.id).where(state: "receveur").each do |user_payment|
    @receveurs << user_payment.user_id
    end

    if @receveurs.length == 1 && @receveurs[0] == @payeur
        @user_budget_payeur[0].dette += 0
      elsif @receveurs.include?(@payeur)
        @user_budget_payeur[0].dette -= @payment.montant_cents.to_f.fdiv(@receveurs.length)
        @user_budget_payeur[0].save
      elsif @receveurs.include?(@payeur) == false
        @user_budget_payeur[0].dette -= @payment.montant_cents.to_i
        @user_budget_payeur[0].save
    end

    @budget.total_cents -= @payment.montant_cents
    @budget.save
    @payment.destroy

    redirect_to budget_path(@budget)
  end

  private

  def payment_params
    params.require(:payment).permit(:montant_cents, :commentaire, :budget_id)
  end


end
