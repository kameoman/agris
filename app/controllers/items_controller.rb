class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]

  def index
    # クエリストリングがあればTimeオブジェクトに変換、ない場合は現在の時刻を取得
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    # 取得した時刻が含まれる月の範囲のデータを取得
    @items = Item.where(date: @month.all_month).order('date ASC')
    @customer = Customer.all
  end

  def report; end

  def show
    @item = Item.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def new
    @item = Item.new
  end

  def edit; end

  # POST /items or /items.json
  def create
    @item = Item.new(item_params)
    @item.customer_id = current_customer.id
    if @item.save
      redirect_to customers_path, notice: '新規データを作成完了しました.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    if @item.update(item_params)
      redirect_to customers_path, notice: 'データの更新が完了しました.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @item.destroy
    redirect_to customers_path, notice: 'データの削除が完了しました.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :date, :send_method, :comment, :count, :standard, :image, :customer_id)
  end

  def ensure_correct_customer
    @item = Item.find(params[:id])
    redirect_to customers_path unless @item.customer == current_customer
  end
end
