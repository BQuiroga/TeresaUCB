class Resume < ActiveRecord::Base
	belongs_to :user
	has_many :experiences, :dependent => :destroy
	has_many :educations, :dependent => :destroy
	has_many :courses, :dependent => :destroy
	has_many :knowledges, :dependent => :destroy
	has_many :publications, :dependent => :destroy
	has_many :merits, :dependent => :destroy
	has_many :memberships, :dependent => :destroy
	has_many :languages, :dependent => :destroy
	has_many :referentials, :dependent => :destroy
	has_many :skills, :dependent => :destroy
end
