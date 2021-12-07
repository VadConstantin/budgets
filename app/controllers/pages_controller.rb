class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  @budgets = Budget.all
  # User.where(id: partage.participants.chars)
  end

end
