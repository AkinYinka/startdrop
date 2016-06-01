class Api::V1::CompanySerializer < Api::V1::BaseSerializer
  attributes :id, :description, :location, :tags

  has_many :jobs
  has_many :submissions, :through => :jobs
end