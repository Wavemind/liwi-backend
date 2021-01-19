class AddTrackReferralToAlgorithm < ActiveRecord::Migration[5.2]
  def change
    add_column :algorithms, :track_referral, :boolean, default: true
  end
end
