class Admin::CustomersController < ApplicationController
  before_action :set_q, only: %i[profile search]

  def index
    @customer_items = Customer.joins(:items)
    # クエリストリングがあればTimeオブジェクトに変換、ない場合は現在の時刻を取得
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    # 取得した時刻が含まれる月の範囲のデータを取得+N+1のcustomerを追加
    @items = Item.where(date: @month.all_month).order('date ASC').includes(:customer)
    # 出荷量データ
    @customer_data = Customer.joins(:items).where(items: { date: @month.all_month }).group(:name).sum(:count)

    @all_data = Customer.joins(:items)

    gon.customer_data = @customer_data
    # graph_labels = Customer.joins(:items).where(items: { date: @month.all_month }).map(&:name).uniq
    gon.graph = Customer.joins(:items).where(items: { date: @month.all_month }).group(:name).sum(:count)
    gon.graph_counts = gon.graph.values
    gon.graph_labels = gon.graph.keys
    # item.where(name: label, date: @month.all_month).sum(:count)
  end

  def search

    if @q.result === []
      redirect_to admin_customers_profile_path, notice: '該当データが見つかりませんでした。'
    else
      @results = @q.result.find_by(@q.id)
    end

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
    # 円グラフに活用
    @graph_items = Item.where(customer_id: @customer).where(date: @month.all_month).group(:name).order(:date).sum(:count)
  end

  def set_q
    @q = Customer.ransack(params[:q])
  end
end
