class Friendship < ActiveRecord::Base
	before_create :no_self
	validates_uniqueness_of :one,:scope => :two
	before_create :not_repeated
	def no_self
		one!=two
	end
	def not_repeated
		none=self.one
		ntwo=self.two		
		@exist=Friendship.where(one: ntwo, two:none)
		@exist.size==0
	end
end
