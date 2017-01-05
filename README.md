# Supa

Ruby object → JSON serialization.

[![Build Status](https://travis-ci.org/distribusion/supa.svg?branch=master)](https://travis-ci.org/distribusion/supa)
[![Code Climate](https://codeclimate.com/github/distribusion/supa/badges/gpa.svg)](https://codeclimate.com/github/distribusion/supa)
[![Test Coverage](https://codeclimate.com/github/distribusion/supa/badges/coverage.svg)](https://codeclimate.com/github/distribusion/supa/coverage)
[![Issue Count](https://codeclimate.com/github/distribusion/supa/badges/issue_count.svg)](https://codeclimate.com/github/distribusion/supa)

## Introduction


## Installation

Add this line to your application's Gemfile

```ruby
gem 'supa'
```

And then execute
```shell
bundle install
```

Or install it yourself as
```
gem install supa
```

## Usage

### Example

```ruby
class Article
  attr_accessor :id, :title, :text, :author, :comments
end
```
```ruby
class Author
  attr_accessor :id, :first_name, :last_name
end
```
```ruby
class Comment
  attr_accessor :id, :text
end
```

```ruby
class ArticleRepresenter
  include Supa::Representable

  define do
    namespace :jsonapi do
      attribute :version, getter: proc { 1.1 }
    end

    namespace :data do
      attribute :id
      attribute :type, getter: proc { 'articles' }

      namespace :attributes do
        attribute :title
        attribute :text
      end

      namespace :relationships do
        object :author do
          namespace :data do
            attribute :id
            attribute :type, getter: proc { 'authors' }
          end
        end

        namespace :comments do
          collection :data, getter: proc { self.comments } do
            attribute :id
            attribute :type, getter: proc { 'comments' }
          end
        end
      end
    end

    collection :included, getter: proc { [self.author] } do
      attribute :id
      attribute :type, getter: proc { 'authors' }

      namespace :attributes do
        attribute :first_name
        attribute :last_name
      end
    end

    collection :included, getter: proc { self.comments }, squash: true  do
      attribute :id
      attribute :type, getter: proc { 'comments' }

      namespace :attributes do
        attribute :text
      end
    end
  end
end
```

```ruby
ArticleRepresenter.new(Article.new).to_json
```

```json
{
  "jsonapi": {
    "version": 1.1
  },
  "data": {
    "id": "7aa15512-1f9d-4a86-98ad-4bb0aae487a2",
    "type": "articles",
    "attributes": {
      "title": "Pilot wave theory",
      "text": "In theoretical physics, the pilot wave theory was the first known example of a hidden variable theory, presented by Louis de Broglie in 1927. Its more modern version, the de Broglie–Bohm theory, remains a non-mainstream attempt to interpret quantum mechanics as a deterministic theory, avoiding troublesome notions such as wave–particle duality, instantaneous wave function collapse and the paradox of Schrödinger's cat."
    },
    "relationships": {
      "author": {
        "data": {
          "id": "52139b0b-bd22-4fc7-adc8-593f16ae034f",
          "type": "authors"
        }
      },
      "comments": {
        "data": [
          {
            "id": "35a88ca5-80ec-4e49-9357-d8a16b8873f8",
            "type": "comments"
          },
          {
            "id": "0e02b198-299a-4e6b-99a0-8f2c33c15b1d",
            "type": "comments"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "52139b0b-bd22-4fc7-adc8-593f16ae034f",
      "type": "authors",
      "attributes": {
        "first_name": "Louis",
        "last_name": "de Broglie"
      }
    },
    {
      "id": "35a88ca5-80ec-4e49-9357-d8a16b8873f8",
      "type": "comments",
      "attributes": {
        "text": "There can exist empty waves, represented by wave functions propagating in space and time but not carrying energy or momentum, and not associated with a particle."
      }
    },
    {
      "id": "0e02b198-299a-4e6b-99a0-8f2c33c15b1d",
      "type": "comments",
      "attributes": {
        "text": "Let's call the concept ghost waves."
      }
    }
  ]
}
```

### `attribute`

### `namespace`

### `object`

### `collection`

#### `:squash` option

Passing `true` to `:squash` option results in merging collection with the previous one

```ruby
class AnimalsRepresenter
  include Supa::Representable

  define do
    collection :animals, getter: -> { [{name: 'Rex', type: 'dogs'}] } do
      attribute :name
      attribute :type
    end

    collection :animals, getter: -> { [{name: 'Tom', type: 'cats'}] }, squash: true do
      attribute :name
      attribute :type
    end
  end
end
```

```ruby
 AnimalsRepresenter.new(nil).to_hash
```

```ruby
{
  animals: [
    {name: 'Rex', type: 'dogs'},
    {name: 'Tom', type: 'cats'}
  ]
}
```

### `:getter` option

Avoid passing Proc objects to `:getter` option because this is little slower than method name passing

```ruby
# Bad
attribute :name, getter: -> { fetch_name }

# Good
attribute :name, getter: :fetch_name
```

## Development

To install dependencies
```shell
bin/setup
```

To run tests
```shell
bundle exec rake test
```

To run benchmarks
```shell
bundle exec rake bench
```

To spin up an interactive prompt that will allow you to experiment
```shell
bin/console
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/distribusion/supa.
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
