class CreatesCardsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.string :name
      t.string :color
      t.string :type
    end
  end
end
