class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :talk_id

      t.timestamps
    end
  end
end
