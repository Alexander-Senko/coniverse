with_options preload: true do
	pin '@hotwired/turbo-rails',      to: 'turbo.min.js'
	pin '@hotwired/stimulus',         to: 'stimulus.min.js'
	pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js'
end

pin_all_from 'app/javascript/controllers', under: 'controllers'
