---
name: lang-ruby
description: Ruby language conventions, tooling, and known issues. Use when working in Ruby projects — writing modules, tests, configs, or debugging Ruby-specific behavior.
---

# Ruby Development

Conventions and known issues for Ruby projects.

## Tooling

- **Formatting/linting**: rubocop
- **Testing**: rspec
- **Package/dependency management**: bundler
- **Version management**: mise (`.tool-versions`, or `mise.toml` if necessary)
    - Also use it to load `.env` files

## Immutable Objects

Prefer immutable objects.
Think of objects as data with properties/attributes.
With immutable objects, it's less problematic to dig in several layers deep.
Use Ruby's `Data` class, using the subclassing syntax:

~~~ ruby
class MyClass < Data.define do
  def extra_method = blah
end
~~~

## Style

- Prefer "endless" methods:

~~~ ruby
def example(a) = a + 1
~~~

- Double-quoted strings by default. Prevents unnecessary change when we all of a sudden need an apostrophe in the string. No slower than single-quoted strings.
- Use `private` as a "prefix" modifier in front of every private method:

~~~ ruby
def abc(x) = blah
private def xyz(x) = foo
private def wxy(q) = bar
~~~

## Rails

- Prefer Hanami over Rails.
