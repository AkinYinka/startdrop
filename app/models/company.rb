class Company < ActiveRecord::Base

	has_many :jobs
	has_many :submissions, :through => :jobs, dependent: :destroy

	devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable
end
