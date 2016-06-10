class Submission < ActiveRecord::Base
	belongs_to :job
	belongs_to :user

	mount_uploader :videos, VideoUploader
end
