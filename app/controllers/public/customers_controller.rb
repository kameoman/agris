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
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    # 取得した時刻が含まれる月の範囲のデータを取得
    @items = @customer.items.where(date: @month.all_month).order('date ASC')
    @item = @items.count

    @customer_1day_items = Item.where(customer_id: current_customer.id).where(created_at: 1.day.ago.all_day)
    # 1ヶ月間の投稿数
    # @customer_today_items = Item.where(customer_id: current_customer.id).where(date: @month.all_month)
    @customer_today_items = Item.where(customer_id: current_customer.id).where(count: @month.all_month)

    @items_all = current_customer.items.all

    # 分析するため
    @graph_items = Item.where(customer_id: current_customer).where(date: @month.all_month).group(:name).order(:date).sum(:count)
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
    redirect_to my_page_path, notice: '会員情報を更新しました' if customer.update(customer_params)
  end

  def destroy
    # binding pry
    customer = Customer.find(params[:id])
    customer.destroy
    flash[:success] = '会員情報を削除しました'
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :kana, :address, :phone_number, :email, :customer_no)
  end

  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    @admin = Admin
    redirect_to customer_path(current_customer) unless @customer == current_customer
  end
end
