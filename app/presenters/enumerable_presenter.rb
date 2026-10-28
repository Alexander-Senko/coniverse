# frozen_string_literal: true

# Presents arrays and other untyped collections. Acts as a fallback for
# collections not presented by collection presenters.
class EnumerablePresenter < Magic::Presenter::Base
	include Coniverse::DOM::Enumerable

	def self.model_class = nil # untyped

	def model_class = common_ancestors(__getobj__).first

	private

	def common_ancestors(*records) = records.flatten
			.map(&:class)
			.uniq
			.map { it.ancestors.grep Class }
			.reduce([], &:&)
end
