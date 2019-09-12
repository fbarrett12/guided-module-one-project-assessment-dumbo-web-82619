class CreateHairdressers < ActiveRecord::Migration[5.2]
  def change
    create_table :hairdressers do |t|
      t.string :name
    end
  end
end
