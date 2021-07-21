# frozen_string_literal: true

class Session
  include ActiveModel::Model

  attr_accessor :email, :password

  validates :email, presence: true
  validates :password, presence: true
  validate  :true_email
  validate  :true_password

  def true_email
    errors.add(:email, 'は使われていません。') unless Customer.find_by(email: email)
  end

  def true_password
    @customer = Customer.find_by(email: email)
    if @customer
      unless @customer.authenticate(password)
        errors.add(:password, 'は正しくありません。')
        end
    else
      errors.add(:password, 'は正しくありません。')
    end
  end

  def save
    return false if invalid?

    true
  end
end
