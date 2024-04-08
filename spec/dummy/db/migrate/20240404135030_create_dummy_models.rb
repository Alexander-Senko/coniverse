class CreateDummyModels < ActiveRecord::Migration[7.1]
  def change
    create_table :dummy_models, id: :uuid do |t|

      t.timestamps
    end
  end
end
