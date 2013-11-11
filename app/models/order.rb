class Order < ActiveRecord::Base
  attr_accessible :milk, :buttermilk, :cream,
  								:driver
  								:buyer_id,
  								:milkrun_id

  belongs_to :buyer, counter_cache: true
  belongs_to :milkrun, counter_cache: true
end
