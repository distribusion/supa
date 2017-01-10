# Supa

Ruby object → JSON serialization.

[![Build Status](https://travis-ci.org/distribusion/supa.svg?branch=master)](https://travis-ci.org/distribusion/supa)
[![Code Climate](https://codeclimate.com/repos/587387071c36ea7203000e0d/badges/19b714c64bf6f028a58c/gpa.svg)](https://codeclimate.com/repos/587387071c36ea7203000e0d/feed)
[![Test Coverage](https://codeclimate.com/repos/587387071c36ea7203000e0d/badges/19b714c64bf6f028a58c/coverage.svg)](https://codeclimate.com/repos/587387071c36ea7203000e0d/coverage)
[![Issue Count](https://codeclimate.com/repos/587387071c36ea7203000e0d/badges/19b714c64bf6f028a58c/issue_count.svg)](https://codeclimate.com/repos/587387071c36ea7203000e0d/feed)

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
```shell
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
      attribute :version, getter: 1.1
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
            attribute :type, proc { 'authors' }
          end
        end

        namespace :comments do
          collection :data, getter: :comments do
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

    collection :included, getter: :comments, squash: true  do
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

## `attribute`
Attributes will be retrieved from correspondingly named instance methods unless a getter is defined:
```ruby
class ExampleRepresenter
  include Supa::Representable

  define do
    attribute :name
  end
end

ExampleRepresenter.new(OpenStruct.new(name: 'Heidi')).to_hash

{
  name: 'Heidi'
}
```
A getter can take several forms:

### 1. Method name
```ruby
class ExampleRepresenter
  include Supa::Representable

  define do
    attribute :name, getter: :full_name
  end
end

class Person
  attr_accessor :full_name
end

example = Person.new
example.full_name = 'Heidi Shepherd'

ExampleRepresenter.new(example).to_hash

{
  name: 'Heidi Shepherd'
}
```
The lookup order is to first check the object instance and then the representer for a matching method.

###2. Hash key
```ruby
class ExampleRepresenter
  include Supa::Representable

  define do
    attribute :name, getter: 'full_name'
  end
end

example = {
  'full_name' => 'Heidi Shepherd'
}

ExampleRepresenter.new(example).to_hash

{
  name: 'Heidi Shepherd'
}

```

###3. Proc
A Proc getter will be evaluated in the context of the object instance. Avoid using Proc getters for accessing
methods or attributes on the object (this is done in the examples below for simplicity) and use the syntax above instead.

```ruby
class ExampleRepresenter
  include Supa::Representable

  define do
    attribute :name, getter: proc { appellation.upcase }
  end
end

class Person
  def initialize(name)
    @name = name
  end

  def appellation
    "Mr or Mrs #{@name}"
  end
end

example = Person.new('Heidi')

ExampleRepresenter.new(example).to_hash

{
  name: 'MR OR MRS HEIDI'
}

```

Methods can also be defined on the Representer class to be referenced in a getter Proc:
```ruby
class ExampleRepresenter
  include Supa::Representable

  define do
    attribute :name, getter: proc { appellation(0) }
  end

  def appellation(index)
    "Dear #{@object.name.split(' ')[index]}"
  end
end

class Person
  def initialize(name)
    @name = name
  end

  attr_reader :name
end

example = Person.new('Heidi Shepherd')

ExampleRepresenter.new(example).to_hash

{
  name: 'Dear Heidi'
}

```

###4. Literal Value
Literal values can be supplied as `String`, `Numeric`, `Time`, `Date`, etc.
```ruby
class ExampleRepresenter
  include Supa::Representable

  define do
    attribute :version, getter: 1.0
    attribute :type, getter: 'documentation'
    attribute :time, getter: Time.now
  end
end

ExampleRepresenter.new({}).to_hash

{
  version: 1.0,
  type: 'documentation',
  time: 2017-01-09 14:45:00 +0100
}
```
If a literal String clashes with a method name it must be wrapped in a proc (as per 3. above):
```ruby
  define do
    attribute :type, getter: proc { 'articles' }
```

## `namespace`

## `object`

## `collection`

### `:squash` option

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
