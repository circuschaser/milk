class Payment < ActiveRecord::Base
  attr_accessible :amount

  belongs_to :buyer
  belongs_to :account
end
