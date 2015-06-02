class CreateRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.integer  :repo_id
    end
  end
end