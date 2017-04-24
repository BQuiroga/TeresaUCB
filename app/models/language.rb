class Language < ActiveRecord::Base
  belongs_to :resume
  def skills
    ["Lectura y Escritura","Comprehension","Habla"]
  end
  def levels
    ["Basico","Regular","Avanzado"]
  end
end
