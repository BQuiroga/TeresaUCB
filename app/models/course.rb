class Course < ActiveRecord::Base
	belongs_to :resume
	def orador
		if given == "Participante"
			"Participante"
		end
		if given == "Aprobacion"
			"Aprobacion"
		end
		if given == "Expositor"
			"Expositor"
		end
		if given == "Organizador"
			"Organizador"
		end
	end
	def self.participations
		["Participante","Aprobacion","Expositor","Organizador"]
	end
end
