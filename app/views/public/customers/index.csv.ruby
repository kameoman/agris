
require 'csv'


bom = "\uFEFF"
CSV.generate(bom) do |csv|
  column_names = %w(name date count standard send_method)
  csv << column_names
  @items.each do |item|
    column_values = [
      item.name,
      item.date,
      item.count,
      item.standard,
      item.send_method
    ]
    csv << column_values
  end
end