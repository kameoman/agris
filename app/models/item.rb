class Item < ApplicationRecord
  enum send_method:{直売所:0,量販店:1}
  belongs_to :customer
  belongs_to :admin, optional: true
  
  attachment :image
end
