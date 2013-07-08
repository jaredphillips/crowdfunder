class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.string :teaser
      t.references :user, index: true
      t.text :description
      t.integer :goal

      t.timestamps
    end
  end
end
