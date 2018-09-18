class Experience < ActiveRecord::Base
	belongs_to :resume
	before_create :validate_date,:set_anonim_salary
	before_update :validate_date
	def set_anonim_salary
		if salary_range==nil
			salary_range="Anonimo"
		end
	end
	def validate_date
		start_date<end_date&& start_date<Time.now
	end
	def isThisMonth
		end_date.month==Time.now.month
	end
	def isThisYear
		end_date.year==Time.now.year
   	end
   	def finish_job_date
   		if (isThisMonth and isThisYear) or until_now
   			"Hasta la fecha"
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
		def user
			resume=self.resume
			user=resume.user
			user
		end
    def self.salary_range
       ["0-3000","3001-6000","6001-9000","9001-14000","14000-20000","20000+","No quiero decirlo"]
    end
		def countries
			["Bolivia","Argentina","Colombia","Peru","Russia","Ecuador","Venezuela","Mexico"]
		end
		def time_in_job
			res=Date.new
			if finish_job_date!="Hasta la fecha"
	    	res= (end_date - start_date).to_i
	    	resp=days_into_years(res)
			else
				return -1
			end
	    resp
	  end
	  def days_into_years(some_date)
	    y=some_date/365
	    m=(some_date%365)/30
	    d=(some_date%365)%30
	    y
	  end
		def local_and_international
			all_info=Experience.all
			r=Hash.new
			r={"Interior"=>0,"Exterior"=>0}
			all_info.each do |experience|
				if experience.city=="Bolivia"
					r["Interior"]+=1
				else
					r["Exterior"]+=1
				end
			end
			r
		end
		def all_cities_for_map
			r=Array.new
			all=Experience.group(:city).count
			r=all.to_a
		end
end
