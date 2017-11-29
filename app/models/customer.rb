class Customer < ActiveRecord::Base
    has_many :sites
    accepts_nested_attributes_for :sites, :allow_destroy => :true
    has_many :circuits, through: :sites
    accepts_nested_attributes_for :circuits, :allow_destroy => :true
    
    has_many :users
end
