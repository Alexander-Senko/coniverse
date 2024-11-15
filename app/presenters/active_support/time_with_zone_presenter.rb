class ActiveSupport::TimeWithZonePresenter < Magic::Presenter::Base
	def tag(**)
		time_tag(self,
				lang: I18n.locale,
		**) do
			render inline: <<~SLIM, type: :slim, locals: { time: self }
				span.year< = time.year
				span.date< = time.date
				span.time< = time.time
			SLIM
		end
	end

	def time = strftime '%k:%M'

	def date
		l(to_date, format: :long)
				.sub(/\P{Alnum}*#{year}\P{Alnum}*/, '')
	end
end
