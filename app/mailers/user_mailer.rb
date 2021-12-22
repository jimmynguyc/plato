class UserMailer < ApplicationMailer
  def send_invoice
    @user = params[:user]
    @duration = params[:duration]
    @amount_due = params[:amount_due]

    mail(to: @user.email, subject: 'Your Plato Invoice')
  end
end
