class Job < ActiveRecord::Base
	belongs_to :company
	has_many :submissions
	has_many :users, :through => :submissions
end
