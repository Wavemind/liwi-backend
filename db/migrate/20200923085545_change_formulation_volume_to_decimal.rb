class ChangeFormulationVolumeToDecimal < ActiveRecord::Migration[5.2]
  def change
    change_column :formulations, :dose_form, :decimal
  end
end
