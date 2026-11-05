# frozen_string_literal: true

SimpleCov.configure do
	enable_coverage :branch
	enable_coverage :eval

	skip '/spec/'

	group 'Models',      'app/models'
	group 'Presenters',  'app/presenters'
	group 'Controllers', 'app/controllers'
	group 'Responders',  'app/responders'
	group 'Helpers',     'app/helpers'
	group 'Jobs',        'app/jobs'
	group 'Mailers',     'app/mailers'
	group 'Channels',    'app/channels'
	group 'Mailboxes',   'app/mailboxes'
	group 'Config',      'config'
	group 'Generators',  'lib/generators'
	group 'Lib',         'lib'
end
