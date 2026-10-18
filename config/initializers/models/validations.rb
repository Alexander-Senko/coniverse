# frozen_string_literal: true

ActiveSupport.on_load :active_record do
	ActiveRecord::Validations.class_methods do
		# Adds support for false values to remove previously defined
		# validations. Normally, Rails just skips them.
		#
		# May be useful for descendants to remove a validation defined by
		# an ancestor class.
		#
		# HACK: this monkey patch may break in future versions of Rails.
		def validates *attributes # HACK
			defaults    = attributes.extract_options!.dup
			validations = defaults.slice! *_validates_default_keys

			raise ArgumentError, 'You need to supply at least one attribute'  if  attributes.empty?
			raise ArgumentError, 'You need to supply at least one validation' if validations.empty?

			defaults[:attributes] = attributes

			validations.each do |key, options|
				key = "#{key.to_s.camelize}Validator"

				begin
					validator = const_get key
				rescue NameError
					raise ArgumentError, "Unknown validator: '#{key}'"
				end

				if options
					validates_with validator, defaults.merge(_parse_validates_options options)
				else
					self._validators         = _validators.dup
					self._validate_callbacks = _validate_callbacks.dup

					attributes.each do |attribute|
						_validators[attribute.to_sym]
								.grep(validator)
								.each { _validators[attribute.to_sym].delete it }
								.tap do |validators|
									_validate_callbacks
											.select { it.filter.in? validators }
											.each { _validate_callbacks.delete it }
								end
					end
				end
			end
		end
	end
end
