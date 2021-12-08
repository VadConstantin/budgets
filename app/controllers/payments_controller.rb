class PaymentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def index
  @payments = Payment.all
  end

  def show
    @budget = Budget.find(params[:budget_id])
    @payment = Payment.find(params[:id])
  end

  def new
    @budget = Budget.find(params[:budget_id])
    @payment = Payment.new
    @participants = @budget.users
  end

  def create
    @budget = Budget.where(id: params[:budget_id])
    @payment = Payment.new(payment_params)
    @payment.budget_id = @budget[0].id
    @payment.save!

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






    @budget[0].total_cents += params[:payment][:montant_cents].to_i
    @budget[0].save!

    if @payment.save!
      redirect_to root_path
    else
      render :new
    end

  end

  private

  def payment_params
    params.require(:payment).permit(:montant_cents, :commentaire, :budget_id)
  end



end
