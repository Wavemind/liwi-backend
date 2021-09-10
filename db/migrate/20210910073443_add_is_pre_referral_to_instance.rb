class AddIsPreReferralToInstance < ActiveRecord::Migration[6.0]
  def change
    add_column :instances, :is_pre_referral, :boolean
  end
end
