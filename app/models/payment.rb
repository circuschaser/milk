class Payment < ActiveRecord::Base
  attr_accessible :date, :category, :amount, :buyer_id

  belongs_to :buyer

  validates :category, presence: true
  validates :amount, presence: true

end
