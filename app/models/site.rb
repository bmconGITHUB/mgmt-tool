class Site < ActiveRecord::Base
  belongs_to :customer
  accepts_nested_attributes_for :customer
  has_many :circuits  
  accepts_nested_attributes_for :circuits, :allow_destroy => :true
end
