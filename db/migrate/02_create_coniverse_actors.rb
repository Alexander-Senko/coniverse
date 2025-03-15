class CreateConiverseActors < ActiveRecord::Migration[8.0]
	def change
		create_table :coniverse_actors, id: :uuid do |t|
			t.string :type, index: true

			t.timestamps
		end
	end
end
