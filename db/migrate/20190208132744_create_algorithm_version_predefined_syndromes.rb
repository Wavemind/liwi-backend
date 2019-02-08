class CreateAlgorithmVersionPredefinedSyndromes < ActiveRecord::Migration[5.2]
  def change
    create_table :algorithm_version_predefined_syndromes do |t|
      t.belongs_to :predefined_syndrome, index: { name: :index_ps_av_id }
      t.belongs_to :algorithm_version, index: { name: :index_av_ps_id }

      t.timestamps
    end
  end
end
