class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.string :useragent
      t.float :lat
      t.float :long

      t.timestamps
    end
  end
end
