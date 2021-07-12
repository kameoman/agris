class Admin::CustomersController < ApplicationController
  def index
        # クエリストリングがあればTimeオブジェクトに変換、ない場合は現在の時刻を取得
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    # 取得した時刻が含まれる月の範囲のデータを取得
    @items = Item.where(date: @month.all_month).order('date ASC')
    @customer = Customer.all
    # binding pry
    @customer_items = Customer.joins(:items)
    # SELECT `customers`.* FROM `customers` INNER JOIN `items` ON `customer_id` = `customers`.`id`
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
