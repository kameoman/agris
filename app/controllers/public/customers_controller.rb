# frozen_string_literal: true

class Public::CustomersController < ApplicationController
  # before_action :admin_scan,only: [:index]
  before_action :authenticate_customer!
  before_action :ensure_correct_customer

  def index
    @items = current_customer.items.all
  end

  def show
    @customer = current_customer
    # end
    @customers = Customer.all
    # クエリストリングがあればTimeオブジェクトに変換、ない場合は現在の時刻を取得
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    # 取得した時刻が含まれる月の範囲のデータを取得
    @items = @customer.items.where(date: @month.all_month).order('date ASC')

    @items_all = current_customer.items.all

    @count_data = current_customer.items.where(date: @month.all_month).select('count')

    # 分析するため
    # @graph_items = Item.where(customer_id: current_customer).where(date: @month.all_month).group(:name).order(:date).sum(:count)
    graph_labels = current_customer.items.where(date: @month.all_month).map(&:name).uniq
    gon.graph_labels = graph_labels
    gon.graph_counts = graph_labels.map do |label|
      current_customer.items.where(name: label, date: @month.all_month).sum(:count)
    end
  end

  def edit
    @customer = Customer.find(params[:id])
    @customers = Customer.find(params[:id])
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
    params.require(:customer).permit(:name, :kana, :address, :phone_number, :email, :customer_no, :latitude, :longitude)
  end

  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    @admin = Admin
    redirect_to customer_path(current_customer) unless @customer == current_customer
  end
end
