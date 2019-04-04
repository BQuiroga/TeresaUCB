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
			["Bolivia","Argentina","Colombia","Peru","Russia","Ecuador","Venezuela","Mexico","Republica Dominicana"]
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
		def jobs_users(time,area)
			users=Array.new
			resp=Array.new
			if area.size>0
				educations=Education.where("title~*?",area)
			else
				educations=Education.all
			end
			experiences=Experience.all
			users=educations.map{ |x| x.user}
			experiences.each do |exp|
				if (exp.time_in_job==time )
					if users.include?(exp.user)
						resp=resp+[exp.user]
					end
				end
				if (time=="Continua trabajando" and exp.time_in_job==-1)
					if users.include?(exp.user)
						resp=resp+[exp.user]
					end
				end
			end
			resp=resp.uniq
			resp
		end
		def country_users(carrera,country)
			resumes=carrera.map{|education| education.resume_id}.uniq
			experiences=Experience.where(resume_id:resumes)
			users=Array.new
			experiences.each do |exp|
				if (exp.city==country)
					users=users+[exp.user]
				end
			end
			users=users.uniq
			users
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
		def paises_de(lista)
			lista.group(:city).count
		end
		def por_regiones(lista)
			r=Hash.new
			r={"Interior"=>0,"Exterior"=>0}
			lista.each do |experience|
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
		def experience_has(cargos,experiencias)
			r=Array.new
			cargos.each do |cargo|
				r=r+Experience.where("job_title~*?",cargo)
			end
			experiencias.each do |exper|
				r=r+Experience.where("job_description~*?",exper)
			end
			r
		end
		def salary_users(salary,area)
			users=Array.new
			resp=Array.new
			if area.size>0
				educations=Education.where("title~*?",area)
			else
				educations=Education.all
			end
			users=educations.map{ |x| x.user}
			experiences=Experience.where(salary_range:salary)
			experiences.each do |exp|
				if users.include?(exp.user)
					resp=resp+[exp.user]
				end
			end
			resp=resp.uniq
			resp
		end
end
