class Note < ActiveRecord::Base
  attr_accessible :body, :buyer_id

  belongs_to :buyer
end
