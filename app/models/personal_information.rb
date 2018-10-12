class PersonalInformation < ActiveRecord::Base
  belongs_to :user
  after_update :translate_birthdate_to_string
  before_update :validate_date
  def gender_to_string
    if gender==true
      return "Masculino"
    end
    if gender==false
      return "Femenino"
    end
    if user.company
      return "Empresa"
    end
  end
  def schools_total
  end
  def validate_date
    birthdate<Time.now
  end
  def translate_birthdate_to_string
    if (birthdate)
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
  end
  def translate_birthday_to_edit
    if (birthdate)
      h=eval(birthdate)
      d=Date.new(h[1],h[2],h[3])
    else
      d=Date.today
    end
    d
  end
  def call_center
    response=nil
    if phone
      return phone
    end
    if cellphone
      return cellphone
    end
    if cellphone and phone
      return cellphone+" - " +phone
    end
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
