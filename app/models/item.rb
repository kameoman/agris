class Item < ApplicationRecord
  enum send_method:{直売所:0,量販店:1}
  belongs_to :customer, optional: true
  belongs_to :admin, optional: true

  attachment :image
end
