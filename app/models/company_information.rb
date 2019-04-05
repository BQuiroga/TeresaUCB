class CompanyInformation < ActiveRecord::Base
  belongs_to :user
  belongs_to :ciu_code
  after_create :dependent
  def dependent
    self.ciu_code_id=1
  end
  def users_for(ciu)
    cius=CiuCode.where(description:ciu)
    empresas=Array.new
    cius.each do |ciuu|
      empresas=empresas+CompanyInformation.where(ciu_code_id:ciuu.id)
    end
    empresas=empresas.map{|x| x.user}.uniq
    empresas
  end
end
