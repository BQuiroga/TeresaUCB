class Language < ActiveRecord::Base
  belongs_to :resume
  def self.skills
    ["Lectura y Escritura","Comprehension","Habla"]
  end
  def self.levels
    ["Basico","Regular","Avanzado"]
  end
end
