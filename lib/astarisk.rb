require "astarisk/version"

if !RubyVM.const_defined?("AbstractSyntaxTree") && !RubyVM.const_defined?("AST")
  raise "use Ruby 2.6.0-preview3 or later"
end

if !RubyVM.const_defined?("AbstractSyntaxTree") && RubyVM.const_defined?("AST")
  RubyVM.const_set("AbstractSyntaxTree", RubyVM::AST)
end

module Astarisk
  def self.draw(node, out: STDERR, mode: :normal)
    out.print draw_graph(node, mode: mode)
    nil
  end

  def self.stringify_node(node)
    case node
    when RubyVM::AbstractSyntaxTree::Node
      "[#{node.type}]\n"
    when Array
      node.to_s + "\n"
    else
      "#{node.class.to_s}(#{node.inspect})\n"
    end
  end

  BAR_TOKEN  = " |\n".freeze
  NODE_TOKEN = " +--".freeze
  BAR_SPACE  = " |  ".freeze
  JUST_SPACE = "    ".freeze

  def self.draw_graph(node, mode: :normal)
    if !node.is_a?(RubyVM::AbstractSyntaxTree::Node)
      return stringify_node(node)
    end
    if node.children.empty?
      return stringify_node(node)
    end

    buffer = String.new(encoding: Encoding::UTF_8)
    buffer << stringify_node(node)

    num_children = node.children.size
    num_children.times do |i|
      terminal = (num_children == i + 1)
      child_graph_lines = draw_graph(node.children[i], mode: mode).lines
      buffer << BAR_TOKEN unless mode == :compact
      buffer << NODE_TOKEN + child_graph_lines.shift
      if terminal
        buffer << child_graph_lines.map{|line| JUST_SPACE + line }.join
      else
        buffer << child_graph_lines.map{|line| BAR_SPACE + line }.join
      end
    end

    buffer
  end
end
