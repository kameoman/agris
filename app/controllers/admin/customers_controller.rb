class Admin::CustomersController < ApplicationController
  def index
        # クエリストリングがあればTimeオブジェクトに変換、ない場合は現在の時刻を取得
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    # 取得した時刻が含まれる月の範囲のデータを取得
    @items = Item.where(date: @month.all_month).order('date ASC')
    @customer = Customer.all
    @customer_items = Customer.joins(:items)
    
    # 1ヶ月間の投稿数
    # binding pry
    #@customer_today_items = Item.where(created_at: Time.zone.now.all_day)
    # @customer_1day_items = Item.where(customer_id: @customer).where(created_at: 1.day.ago.all_day)
  end

  def profile
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
        # クエリストリングがあればTimeオブジェクトに変換、ない場合は現在の時刻を取得
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    # 取得した時刻が含まれる月の範囲のデータを取得
    @items = @customer.items.where(date: @month.all_month).order('date ASC')
  end



end
