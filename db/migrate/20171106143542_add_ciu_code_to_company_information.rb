class AddCiuCodeToCompanyInformation < ActiveRecord::Migration
  def change
    add_reference :company_informations, :ciu_code, index: true, foreign_key: true
  end
end
