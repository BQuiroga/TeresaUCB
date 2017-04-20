class PersonalInformation < ActiveRecord::Base
  belongs_to :user
  after_update :translate_birthdate_to_string
  def translate_birthdate_to_string
  	birthdate.remove!("{")
  	birthdate.remove!("}")
  	birthdate.remove!(' ')
  	cad_aux=""
  	birthdate.split(',').each do |a|
  		cad_aux=cad_aux+"/"+a.from(3)
  	end
  	cad_aux=cad_aux.from(1)
  	cad_aux=cad_aux.to_date
  	birthdate=cad_aux
  end
  def literal(fecha)
   		fecha.day.to_s +" "+ mes(fecha.month) +" "+ fecha.year.to_s
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