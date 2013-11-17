class Payment < ActiveRecord::Base
  attr_accessible :amount, :buyer_id

  belongs_to :buyer
end
