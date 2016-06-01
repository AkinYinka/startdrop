class Api::V1::JobSerializer < Api::V1::BaseSerializer
  attributes :id, :title, :description, :salary_range, :deadline, :tags, :questions

  has_many :submissions
end