class Course < ActiveRecord::Base
	belongs_to :resume
	def orador
		if given
			"Orador"
		else
			"Participante"
		end
	end
	def participations
		["Participante","Aprobacion","Expositor","Organizador"]
	end
end
