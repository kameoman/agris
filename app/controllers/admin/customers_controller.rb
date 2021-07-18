class Admin::CustomersController < ApplicationController
  before_action :set_q, only: [:profile, :search]


  def index
    # クエリストリングがあればTimeオブジェクトに変換、ない場合は現在の時刻を取得
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    # 取得した時刻が含まれる月の範囲のデータを取得+N+1のcustomerを
    @items = Item.where(date: @month.all_month).order('date ASC').includes(:customer)
    @customer = Customer.all
    @customer_items = Customer.joins(:items)
    # 出荷量データ
    @customer_data = Customer.joins(:items).where(items: {date: @month.all_month}).group(:name).sum(:count)

  end

  def search
    @results = @q.result

    @customer = @results

    @address = @q.result.select("id,address,latitude,longitude").find_by(@q.id)



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

    def set_q
    @q = Customer.ransack(params[:q])
    end


end
