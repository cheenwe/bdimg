class CreateSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :searches do |t|
      t.string :name
      t.integer :number
      t.integer :total

      t.timestamps
    end
  end
end
