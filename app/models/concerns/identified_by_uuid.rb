concern :IdentifiedByUUID do
	class_methods do
		def find *ids
			ids.map! do |id|
				next id if id.match? /\A(\h{8})-?(\h{4})-?(\h{4})-?(\h{4})-?(\h{4})(\h{8})\z/

				id_from_param id
			end

			super
		end

		private

		def id_from_param id
			Base64
					.urlsafe_decode64(id)
					.unpack('C*')
					.map { '%02x' % _1 }
					.join
		end
	end

	def to_param
		return super if new_record?

		Base64
				.urlsafe_encode64(id
						.remove('-')
						.to_i(16)
						.digits(256)
						.reverse
						.pack('C*')
				)
				.remove(/=+\z/)
	end
end
