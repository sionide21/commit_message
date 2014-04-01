# CommitMessage

Convert a commit message into a reasonable description

## Installation

Add this line to your application's Gemfile:

    gem 'commit_message'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install commit_message

## Usage

For the head of a repository in the working directory:

```ruby
puts CommitMessage.new
```

For a specific revision:

```ruby
puts CommitMessage.new(revision: "master")
```

For a different repo:

```ruby
puts CommitMessage.new(repo: "/path/to/repo")
```

## Contributing

1. Fork it ( http://github.com/sionide21/commit_message/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
