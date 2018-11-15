# Astarisk

Astarisk is a tool to visualize `RubyVM::AbstractSyntaxTree` nodes on console.

That is named as "AST a risk".

NOTE: `RubyVM::AbstractSyntaxTree` is defined as `RubyVM::AST` in Ruby 2.6.0 preview3, but it'll be renamed to `RubyVM::AbstractSyntaxTree` in later versions.

## Usage

**NOTE: Use Ruby 2.6.0 preview3 or later**

1. Get an AST using methods blow:
 * `RubyVM::AbstractSyntaxTree#parse` (from ruby code)
 * `RubyVM::AbstractSyntaxTree#parse_file` (from file path)
 * `RubyVM::AbstractSyntaxTree#of` (from an object of Method or Proc)
2. Get a graph string
 * `Astarisk.draw_graph(ast)`
3. Or draw graph on STDERR (in default)
 * `Astarisk.draw(ast)`

Output example from a blank Proc object:

```
[NODE_SCOPE]
 |
 +--[]
 |
 +--[NODE_ARGS]
 |   |
 |   +--Integer(0)
 |   |
 |   +--NilClass(nil)
 |   |
 |   +--NilClass(nil)
 |   |
 |   +--NilClass(nil)
 |   |
 |   +--Integer(0)
 |   |
 |   +--NilClass(nil)
 |   |
 |   +--NilClass(nil)
 |   |
 |   +--NilClass(nil)
 |   |
 |   +--NilClass(nil)
 |   |
 |   +--NilClass(nil)
 |
 +--[NODE_BEGIN]
     |
     +--NilClass(nil)
```

Output example in compact format:

```
[NODE_SCOPE]
 +--[]
 +--[NODE_ARGS]
 |   +--Integer(0)
 |   +--NilClass(nil)
 |   +--NilClass(nil)
 |   +--NilClass(nil)
 |   +--Integer(0)
 |   +--NilClass(nil)
 |   +--NilClass(nil)
 |   +--NilClass(nil)
 |   +--NilClass(nil)
 |   +--NilClass(nil)
 +--[NODE_BEGIN]
     +--NilClass(nil)
```

## Methods

### Astarisk.draw

Draw a graph on specified I/O destination (default: STDERR)

Arguments:
 * AST node (an instance of `RubyVM::AbstractSyntaxTree::Node`)

Keyword arguments:
 * out: output I/O to draw graph (default: `STDERR`)
 * mode: symbol to specify `:compact` mode (default: `:normal`)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tagomoris/astarisk.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
