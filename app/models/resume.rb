class Resume < ActiveRecord::Base
	belongs_to :user
	has_many :experiences
	has_many :educations
	has_many :courses
	has_many :knowledges
	has_many :publications
	has_many :merits
	has_many :memberships
	has_many :languages
	has_many :referentials
end
