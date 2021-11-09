class RenameAgeLimitMessageHstore < ActiveRecord::Migration[6.0]
  def change
    rename_column :versions, :age_limit_message, :age_limit_message_translations
  end
end
