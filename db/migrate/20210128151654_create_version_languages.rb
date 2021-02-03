class CreateVersionLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :version_languages do |t|
      t.belongs_to :version
      t.belongs_to :language
    end
  end
end
