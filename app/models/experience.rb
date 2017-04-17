class Experience < ActiveRecord::Base
	belongs_to :resume
	def isThisMonth
		end_date.month==Time.now.month
	end
	def isThisYear
		end_date.year==Time.now.year
   	end
   	def finish_job_date
   		if isThisMonth and isThisYear
   			"Actualidad"
   		else
   			literal(end_date)
   		end
   	end
   	def start_job_date
   		literal(start_date)
   	end
   	def literal(fecha)
   		mes(fecha.month) +" "+ fecha.year.to_s
   	end
   	def mes(mesNumero)
   		case mesNumero
   		when 1
   			"Enero"
   		when 2
   			"Febrero"
   		when 3
   			"Marzo"
   		when 4
   			"Abril"
   		when 5
   			"Mayo"
   		when 6
   			"Junio"
   		when 7
   			"Julio"
   		when 8
   			"Agosto"
   		when 9
   			"Septiembre"
   		when 10 
   			"Octubre"
   		when 11
   			"Noviembre"
   		when 12
   			"Diciembre"
   		end


   	end
end
