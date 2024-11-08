# frozen_string_literal: true

Rails.application.config.to_prepare do
	Enumerable.include Magic::Presentable
end
