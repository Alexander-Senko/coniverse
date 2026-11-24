# Con!verse
*Everything is a message!*

![A universe of interconnected messages and multimedia information](docs/images/universe.png)

Con!verse is a Ruby on Rails Engine for building a distributed multimedia message graph — a Universe of connected information.

The Web connects documents. Con!verse aims to connect everything: conversations, emails, posts, websites, media, data and any other form of information, regardless of where it originates or how it is presented.

## A Universe of messages

Information is traditionally confined to the applications and formats in which it was created. Conversations live in messengers, documents in editors, posts on social networks, and media in specialized platforms.

Con!verse explores a different paradigm: **information as messages, messages as building blocks, and connections as the foundation of a universal information space.**

A _message_ isn’t necessarily a piece of text or a chat message. It can represent virtually anything — from an individual thought, comment or file to an entire conversation, website or multimedia experience.

_Messages_ can be connected, combined, referenced and reused, creating a graph that evolves organically rather than remaining confined to isolated applications and data silos.

## Beyond the Web

The Web revolutionized access to information. Con!verse explores how information itself could become more connected.

- **Universal** — information isn’t limited to predefined content types or particular applications.
- **Connected** — messages can relate to one another, forming a graph of knowledge, context and meaning.
- **Multimedia** — text, images, audio, video and other forms of information coexist as parts of the same system.
- **Composable** — complex structures and experiences can emerge from connected messages.
- **Distributed** — the vision extends beyond a single application or platform, towards a connected information space.

## The Engine

Con!verse is a Ruby on Rails Engine intended to provide the foundation for building this ecosystem.

It is designed to be integrated into Rails applications and extended to accommodate kinds of messages, relationships and experiences.

## Development status

> [!IMPORTANT]
> Con!verse is under active development. APIs, architecture and functionality may change.

## Installation

Add this line to your application’s Gemfile:
```ruby
gem "coniverse"
```

And then execute:
```bash
$ bundle
```

Mount the Engine in `config/routes.rb`:
```ruby
mount Coniverse::Engine => "/"
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
