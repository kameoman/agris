class Tag < ApplicationRecord
   belongs_to :item, optional: true
end
