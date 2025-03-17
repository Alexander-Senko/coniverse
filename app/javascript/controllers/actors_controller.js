import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
	static actorSelector      = '.actor[id]'
	static authorableSelector = 'article, section'
	static observableSelector = '#messages'

	currentID() { return this.element.dataset.currentId }

	connect() {
		this.setup()

		// Handle updates
		const onUpdate = this.#onUpdate.bind(this)

		for (const event of [
			'turbo:before-frame-render',
		]) addEventListener(event, onUpdate)

		// HACK: Turbo Streams lack an adequate rendering event
		const messages = document.getElementById('messages')
		if (messages)
			new MutationObserver((mutations) => {
				for (const mutation of mutations)
					for (const element of mutation.addedNodes)
						this.setup(element)
			}).observe(messages, { childList: true })
	}

	setup(element = document.body) {
		this.#actorElements(element)
			.forEach(this.#setupActor.bind(this))
		this.#authorableElements(element)
			.forEach(this.#setupAuthorable.bind(this))

		if (element.matches(this.constructor.authorableSelector))
			this.#setupAuthorable(element)
	}

	#actorElements(parent = document.body, selector = '') {
		return parent.querySelectorAll(this.constructor.actorSelector + selector)
	}

	#authorableElements(parent = document.body) {
		return new Set(
			Array.from(this.#actorElements(parent))
				.map(el => el.closest(this.constructor.authorableSelector))
				.filter(el => el)
		)
	}

	#setupActor(element) {
		const current = element.dataset.id === this.currentID()

		element.classList[current ? 'add' : 'remove']('current')

		// Switch action
		const form = element.querySelector('form')
		if (form)
			form._method.value = current ? 'delete' : 'put'
	}

	#setupAuthorable(element) {
		const current = element.querySelector('.actor.current') !== null

		element.classList[current ? 'add' : 'remove']('by-current-actor')
	}

	#onUpdate(event) {
		const defaultRender = event.detail.render
		event.detail.render = (currentElement, newElement) => {
			this.setup(newElement)

			defaultRender(currentElement, newElement)
		}
	}
}
