class Course < ActiveRecord::Base
	belongs_to :resume
	before_create :validate_date
	before_update :validate_date
	def validate_date
		date<Time.now and not3102(date) and not3002(date)
	end
	# def orador
	# 	if given == "Participante"
	# 		"Participante"
	# 	end
	# 	if given == "Aprobacion"
	# 		"Aprobacion"
	# 	end
	# 	if given == "Expositor"
	# 		"Expositor"
	# 	end
	# 	if given == "Organizador"
	# 		"Organizador"
	# 	end
	# end
	def not3102(date)
		if date.day==31 and date.month==2
			return false
		end
		return true
	end
	def not3002(date)
		if date.day==30 and date.month==2
			return false
		end
		return true
	end
	def self.participations
		["Participante","Aprobacion","Expositor","Organizador"]
	end
	def user
		resume=self.resume
		user=resume.user
	end
end
