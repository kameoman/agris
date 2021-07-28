
require 'csv'


bom = "\uFEFF"
CSV.generate(bom) do |csv|
  column_names = %w( 生産者 品目名 出荷日 数量 規格 出荷先)
  csv << column_names
  @items.each do |item|
    column_values = [
    if item.customer.nil?
      "Guest User"
    else
      item.customer&.name
    end,
      item.name,
      item.date.strftime('%Y/%m/%d'),
      item.count,
      item.standard,
      item.send_method
    ]
    csv << column_values
  end
end