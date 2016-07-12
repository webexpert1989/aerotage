class ChangeLastSentInSearches < ActiveRecord::Migration
  def change
    change_column :searches, :last_sent, :datetime
  end
end
