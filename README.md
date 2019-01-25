# ExactZero

This gem provides `Numeric#exact_zero?`, which determine the occurrence of zero division error in advance.

There are some ideas of the judgement in the article https://qiita.com/HMMNRST/items/6cf7e7cc853e5d627a72. (Japanese)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'exact_zero'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install exact_zero

## Usage

```ruby
require 'exact_zero'

Integer("0")   .exact_zero?   #=> true
Rational("0")  .exact_zero?   #=> true
Float("0")     .exact_zero?   #=> false
Complex("0")   .exact_zero?   #=> true
Complex("0.0i").exact_zero?   #=> false

require 'bigdecimal'
BigDecimal("0").exact_zero?   #=> false
```

### Example 1: avoid ZeroDivisionError

```ruby
require 'exact_zero'

class Numeric
	def reciprocal
		1.quo(self)
	end

	def reciprocal_safe
		exact_zero? ? nil : reciprocal
	end
end

num1 = 0.0
num1.reciprocal        #=> Infinity
num1.reciprocal_safe   #=> Infinity

num2 = Complex(0, 0/1r)
num2.reciprocal        #=> ZeroDivisionError: divided by 0
num2.reciprocal_safe   #=> nil
```

### Example 2: Complex to Real

```ruby
require 'exact_zero'

class Complex
	%w(to_f to_r to_i).each do |name|
		define_method("try_#{name}") do
			imag.exact_zero? ? send(name) : nil
		end
	end
end

num1 = Complex("3+0/1i")
num1.to_f       #=> 3.0
num1.try_to_f   #=> 3.0

num2 = Complex("3+0.0i")
num2.to_f       #=> RangeError: can't convert 3+0.0i into Float
num2.try_to_f   #=> nil
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hmmnrst/exact_zero.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
