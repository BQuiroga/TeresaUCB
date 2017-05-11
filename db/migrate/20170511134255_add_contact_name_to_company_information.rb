class AddContactNameToCompanyInformation < ActiveRecord::Migration
  def change
    add_column :company_informations, :contact_name, :string
  end
end
