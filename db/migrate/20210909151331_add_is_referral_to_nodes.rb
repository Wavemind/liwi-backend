class AddIsReferralToNodes < ActiveRecord::Migration[6.0]
  def change
    add_column :nodes, :is_referral, :boolean, default: false
  end
end
