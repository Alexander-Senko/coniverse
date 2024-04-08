class DummyModelDecorator < Coniverse::ApplicationDecorator
	delegate_all

	def flag3? = true
	def flag4? = false
end
