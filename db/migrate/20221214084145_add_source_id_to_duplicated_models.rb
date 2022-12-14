class AddSourceIdToDuplicatedModels < ActiveRecord::Migration[6.0]
  def change
    add_reference :diagnoses, :source, index: true
    add_foreign_key :diagnoses, :diagnoses, column: :source_id

    add_reference :nodes, :source, index: true
    add_foreign_key :nodes, :nodes, column: :source_id

    add_reference :instances, :source, index: true
    add_foreign_key :instances, :instances, column: :source_id

    add_reference :answers, :source, index: true
    add_foreign_key :answers, :answers, column: :source_id

    add_reference :conditions, :source, index: true
    add_foreign_key :conditions, :conditions, column: :source_id

    add_reference :medias, :source, index: true
    add_foreign_key :medias, :medias, column: :source_id
  end
end
