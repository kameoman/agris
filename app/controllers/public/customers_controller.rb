class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    customer = Customer.find(params[:id])
    if customer.update(customer_params)
      redirect_to my_page_path, notice:'会員情報を更新しました'
    end
  end

  def destroy
  # binding pry
   customer = Customer.find(params[:id])
   customer.destroy
   flash[:success] = "会員情報を削除しました"
   redirect_to root_path
  end

  private
  def customer_params
    params.require(:customer).permit(:name, :kana, :address, :phone_number, :email, :customer_no)
  end
end
