class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.integer  :user_id
      t.integer  :repo_id
      t.integer  :commit_count
      t.integer  :additions
      t.integer  :deletions
    end
  end
end