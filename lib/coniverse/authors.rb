# frozen_string_literal: true

require_relative '../../vendor/gems/rubygems-author/lib/rubygems/author'

module Coniverse
	class Author < Gem::Author # :nodoc:
		new(
				name:   'Alexander Senko',
				email:  'Alexander.Senko@gmail.com',
				github: 'Alexander-Senko',
		)
	end
end
