# Administrate::DefaultOrder

[![Build Status: master](https://travis-ci.com/XPBytes/administrate-default_order.svg)](https://travis-ci.com/XPBytes/administrate-default_order)
[![Gem Version](https://badge.fury.io/rb/administrate-default_order.svg)](https://badge.fury.io/rb/administrate-default_order)
[![MIT license](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)

Add default ordering to Administrate controllers.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'administrate-default_order'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install administrate-default_order

## Usage

`include 'Administrate::DefaultOrder'` in your base admin `ApplicationController`:

```ruby
require 'administrate/default_order'

class ApplicationController < Administrate::ApplicationController
  include Administrate::DefaultOrder
end

class BookController < ApplicationController
  default_order Book, name: :asc
end
```

⚠ If you're on a recent `administrate` version, you'll (temporarily) need to add the following to your base controller / application controller:

```ruby
def sorting_params
  from_query = super
  return from_query if from_query.present?

  params.fetch(resource_name) { ActionController::Parameters.new({}) }
        .permit(:direction, :order)
end
```

That's because `sorting_params` used to work directly on `params` and now it works on `request.query_parameters` only, so it can't conflict with locally passing `params` with the exact same name. This re-introduces that constraint, but also makes `DefaultOrder` work again. A future update to this library will resolve this limitation.

## Related

- [`Administrate`](https://github.com/thoughtbot/administrate): A Rails engine that helps you put together a super-flexible admin dashboard.
- [`Administrate::BaseController`](https://github.com/XPBytes/administrate-base_controller): :stars: A set of application controller improvements.

### Concerns

- [`Administrate::SerializedFields`](https://github.com/XPBytes/administrate-serialized_fields): :ab: Automatically deserialize administrate fields on form submit.

### Fields

- [`Administrate::Field::Code`](https://github.com/XPBytes/administrate-field-code): :pencil: A `text` field that shows code.
- [`Administrate::Field::Hyperlink`](https://github.com/XPBytes/administrate-field-hyperlink): :pencil: A `string` field that is shows a hyperlink.
- [`Adminisrtate::Field::JsonEditor`](https://github.com/XPBytes/administrate-field-json_editor): :pencil: A `text` field that shows a [JSON editor](https://github.com/josdejong/jsoneditor).
- [`Administrate::Field::ScopedBelongsTo`](https://github.com/XPBytes/administrate-field-scoped_belongs_to): :pencil: A `belongs_to` field that yields itself to the scope `lambda`.
- [`Administrate::Field::ScopedHasMany`](https://github.com/XPBytes/administrate-field-scoped_has_many): :pencil: A `has_many` field that yields itself to the scope `lambda`.
- [`Administrate::Field::TimeAgo`](https://github.com/XPBytes/administrate-field-time_ago): :pencil: A `date_time` field that shows its data as `time_ago` since.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can
also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the
version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at [XPBytes/administrate-default_order](https://github.com/XPBytes/administrate-default_order).
