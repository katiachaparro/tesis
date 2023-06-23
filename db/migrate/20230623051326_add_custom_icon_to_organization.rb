class AddCustomIconToOrganization < ActiveRecord::Migration[6.1]
  def change
    add_column :organizations, :custom_icon, :string
  end
end
