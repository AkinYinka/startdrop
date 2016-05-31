class Api::V1::UserSerializer < Api::V1::BaseSerializer
  attributes :id, :email, :uid, :name, :experience, :education, :location, :age, :intro_video, :resume, :tags

  has_many :submissions
end