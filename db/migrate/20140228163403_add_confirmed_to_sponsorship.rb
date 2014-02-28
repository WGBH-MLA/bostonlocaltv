class AddConfirmedToSponsorship < ActiveRecord::Migration
  def change
  	add_column :sponsorships, :confirmed, :boolean, :default => false
  end
end
