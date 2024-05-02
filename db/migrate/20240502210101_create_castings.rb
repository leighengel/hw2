class CreateCastings < ActiveRecord::Migration[7.1]
  def change
    create_table :castings do |t|
      t.references :movie, foreign_key: true
      t.references :actor, foreign_key: true
      t.boolean :top_billed

      t.timestamps
    end
  end
end
