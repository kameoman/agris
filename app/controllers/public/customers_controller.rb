class Public::CustomersController < ApplicationController
  # before_action :admin_scan,only: [:index]
  before_action :authenticate_customer!

  def index
    # if current_customer.email == 'guest@example.com'
    #   @customer = "ゲスト"
    # else
    @customer = current_customer
    # end
    @customers = Customer.all
        # クエリストリングがあればTimeオブジェクトに変換、ない場合は現在の時刻を取得
    # binding pry
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    # 取得した時刻が含まれる月の範囲のデータを取得
    @items = @customer.items.where(date: @month.all_month).order('date ASC')
  end

  def show
    @customer = Customer.find(params[:id])
    @items = @customer.items
  end



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

  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    @admin = Admin
    unless @customer == current_customer
      redirect_to customer_path(current_customer)
    end
  end


end
