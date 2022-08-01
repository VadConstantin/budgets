class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @payments = Payment.all.sort_by { |p| p.updated_at }.reverse!
  end

end
