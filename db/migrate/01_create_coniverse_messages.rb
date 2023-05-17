class CreateConiverseMessages < ActiveRecord::Migration[7.1]
	def change
		create_table :coniverse_messages, id: :uuid do |t|
			t.string :type,     index: true

			t.string :lang,     index: true
			t.string :url,      index: true
			t.text   :body
			t.jsonb  :metadata, default: {}

			t.timestamps
		end
	end
end
