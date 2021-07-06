json.extract! item, :id, :name, :date, :send, :comment, :count, :standard, :image_id, :created_at, :updated_at
json.url item_url(item, format: :json)
