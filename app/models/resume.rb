class Resume < ActiveRecord::Base
	belongs_to :user
	has_many :experiences, :educations
end
