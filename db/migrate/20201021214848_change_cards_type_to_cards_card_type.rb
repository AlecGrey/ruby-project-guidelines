class ChangeCardsTypeToCardsCardType < ActiveRecord::Migration[6.0]
  def change
    change_table :cards do |t|
      t.rename :type, :card_type
    end
  end
end
