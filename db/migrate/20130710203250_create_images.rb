class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :image
      t.string :name
      t.string :description
      t.references :project, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
