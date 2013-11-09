# SourceIds

SourceIds enables indirect association replacement via \_source_ids=.
This feature is only for has_many :through associations.

## Installation

Add this line to your application's Gemfile:

    gem 'source_ids'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install source_ids

## Usage

If you have group_users and users associations,

    has_many :group_users
    has_many :users, :through => :group_users

You can use group.user_ids= to replace users and save them in Rails.

But you can't just change your association objects without saving them.

This gem make it possible with group.\_user_ids=.

To enable \_user_ids=, add like this.

    accepts_source_ids_for :users

This also add \_user_ids method that returns active (not marked for destruction) records' ids.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
