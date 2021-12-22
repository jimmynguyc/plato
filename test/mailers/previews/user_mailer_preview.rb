# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/send_invoice
  def send_invoice
    UserMailer.with(
      user: User.new(first_name: 'Foo', email: 'foo@example.com'),
      duration: 12.months,
      amount_due: 100.0
    ).send_invoice
  end
end
