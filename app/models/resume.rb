class Resume < ActiveRecord::Base
	belongs_to :user
	has_many :experiences
	has_many :educations
	has_many :courses
end
