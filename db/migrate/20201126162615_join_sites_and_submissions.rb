class JoinSitesAndSubmissions < ActiveRecord::Migration[5.2]
  def change
    create_table :site_records do |t|
      t.belongs_to :site
      t.belongs_to :submission
      t.timestamps
    end

    def change
      delete_column :submission, :site_id#, :site_ids
      # change_column :submission, :site_ids, 
    end
  end
end
