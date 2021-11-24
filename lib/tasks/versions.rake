namespace :versions do
  desc "Will copy all the final diagnoses exclusion from one version to another "
    task :copy_final_diagnoses_exlusion, [:version_source_id, :version_destination_id] => :environment do |t, args|
      ActiveRecord::Base.transaction(requires_new: true) do
        begin
          puts "#{Time.zone.now.strftime("%I:%M")} - Copying the final diagnoses exclusion"
          version_destination = Version.find(args[:version_destination_id])
          version_source = Version.find(args[:version_source_id])
          
          puts "Delete exclusion in destination version"
          destination_final_diagnosis_ids = version_destination.diagnoses.includes(:final_diagnoses).map(&:final_diagnoses).flatten.map(&:id)
          destination_exclusions = NodeExclusion.includes(:excluded_node, :excluding_node).joins(:excluded_node, :excluding_node).where(excluding_node_id: destination_final_diagnosis_ids, excluded_node_id: destination_final_diagnosis_ids)
          destination_exclusions.destroy_all
          
          puts "Retrieve exclusion in source version"
          final_diagnosis_ids = version_source.diagnoses.includes(:final_diagnoses).map(&:final_diagnoses).flatten.map(&:id)
          exclusions = NodeExclusion.includes(:excluded_node, :excluding_node).joins(:excluded_node, :excluding_node).where(excluding_node_id: final_diagnosis_ids, excluded_node_id: final_diagnosis_ids)
          exclusions.map do |exclusion|
            excluded_node = version_destination.final_diagnoses.find_by(reference: exclusion.excluded_node.reference)
            excluding_node = version_destination.final_diagnoses.find_by(reference: exclusion.excluding_node.reference)
            NodeExclusion.create!(excluded_node: excluded_node, excluding_node: excluding_node, node_type: "final_diagnosis")
          end
      rescue => e
        puts e
        puts e.backtrace
        raise ActiveRecord::Rollback, ''
      end 
    end
  end
end
