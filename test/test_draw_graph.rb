require "test/unit"
require "astarisk"

class AstariskTest < ::Test::Unit::TestCase
  def foo(var)
    var
  end

  BLANK_PROC_AST = <<END_BLANK
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
END_BLANK

  BLANK_PROC_COMPACT_AST = <<END_BLANK_COMPACT
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
END_BLANK_COMPACT

  BLOCK1 = ->(a){ foo(a.to_i.to_s + "bar").itself }
  BLOCK1_AST = <<END_BLOCK1
[NODE_SCOPE]
 |
 +--[:a]
 |
 +--[NODE_ARGS]
 |   |
 |   +--Integer(1)
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
 +--[NODE_CALL]
     |
     +--[NODE_FCALL]
     |   |
     |   +--Symbol(:foo)
     |   |
     |   +--[NODE_ARRAY]
     |       |
     |       +--[NODE_OPCALL]
     |       |   |
     |       |   +--[NODE_CALL]
     |       |   |   |
     |       |   |   +--[NODE_CALL]
     |       |   |   |   |
     |       |   |   |   +--[NODE_DVAR]
     |       |   |   |   |   |
     |       |   |   |   |   +--Symbol(:a)
     |       |   |   |   |
     |       |   |   |   +--Symbol(:to_i)
     |       |   |   |   |
     |       |   |   |   +--NilClass(nil)
     |       |   |   |
     |       |   |   +--Symbol(:to_s)
     |       |   |   |
     |       |   |   +--NilClass(nil)
     |       |   |
     |       |   +--Symbol(:+)
     |       |   |
     |       |   +--[NODE_ARRAY]
     |       |       |
     |       |       +--[NODE_STR]
     |       |       |   |
     |       |       |   +--String("bar")
     |       |       |
     |       |       +--NilClass(nil)
     |       |
     |       +--NilClass(nil)
     |
     +--Symbol(:itself)
     |
     +--NilClass(nil)
END_BLOCK1

  def method1(a)
    foo(a.to_i.to_s + "bar").itself
  end

  METHOD1_AST = <<METHOD1_END
[NODE_SCOPE]
 |
 +--[:a]
 |
 +--[NODE_ARGS]
 |   |
 |   +--Integer(1)
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
 +--[NODE_CALL]
     |
     +--[NODE_FCALL]
     |   |
     |   +--Symbol(:foo)
     |   |
     |   +--[NODE_ARRAY]
     |       |
     |       +--[NODE_OPCALL]
     |       |   |
     |       |   +--[NODE_CALL]
     |       |   |   |
     |       |   |   +--[NODE_CALL]
     |       |   |   |   |
     |       |   |   |   +--[NODE_LVAR]
     |       |   |   |   |   |
     |       |   |   |   |   +--Symbol(:a)
     |       |   |   |   |
     |       |   |   |   +--Symbol(:to_i)
     |       |   |   |   |
     |       |   |   |   +--NilClass(nil)
     |       |   |   |
     |       |   |   +--Symbol(:to_s)
     |       |   |   |
     |       |   |   +--NilClass(nil)
     |       |   |
     |       |   +--Symbol(:+)
     |       |   |
     |       |   +--[NODE_ARRAY]
     |       |       |
     |       |       +--[NODE_STR]
     |       |       |   |
     |       |       |   +--String("bar")
     |       |       |
     |       |       +--NilClass(nil)
     |       |
     |       +--NilClass(nil)
     |
     +--Symbol(:itself)
     |
     +--NilClass(nil)
METHOD1_END

  def method2(a, b)
    v1 = a.map{|i| i.to_s }.join
    v2 = b.upcase
    "#{v1}, #{v2}"
  end

  METHOD2_AST = <<METHOD2_END
[NODE_SCOPE]
 |
 +--[:a, :b, :v1, :v2]
 |
 +--[NODE_ARGS]
 |   |
 |   +--Integer(2)
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
 +--[NODE_BLOCK]
     |
     +--[NODE_LASGN]
     |   |
     |   +--Symbol(:v1)
     |   |
     |   +--[NODE_CALL]
     |       |
     |       +--[NODE_ITER]
     |       |   |
     |       |   +--[NODE_CALL]
     |       |   |   |
     |       |   |   +--[NODE_LVAR]
     |       |   |   |   |
     |       |   |   |   +--Symbol(:a)
     |       |   |   |
     |       |   |   +--Symbol(:map)
     |       |   |   |
     |       |   |   +--NilClass(nil)
     |       |   |
     |       |   +--[NODE_SCOPE]
     |       |       |
     |       |       +--[:i]
     |       |       |
     |       |       +--[NODE_ARGS]
     |       |       |   |
     |       |       |   +--Integer(1)
     |       |       |   |
     |       |       |   +--NilClass(nil)
     |       |       |   |
     |       |       |   +--NilClass(nil)
     |       |       |   |
     |       |       |   +--NilClass(nil)
     |       |       |   |
     |       |       |   +--Integer(0)
     |       |       |   |
     |       |       |   +--NilClass(nil)
     |       |       |   |
     |       |       |   +--NilClass(nil)
     |       |       |   |
     |       |       |   +--NilClass(nil)
     |       |       |   |
     |       |       |   +--NilClass(nil)
     |       |       |   |
     |       |       |   +--NilClass(nil)
     |       |       |
     |       |       +--[NODE_CALL]
     |       |           |
     |       |           +--[NODE_DVAR]
     |       |           |   |
     |       |           |   +--Symbol(:i)
     |       |           |
     |       |           +--Symbol(:to_s)
     |       |           |
     |       |           +--NilClass(nil)
     |       |
     |       +--Symbol(:join)
     |       |
     |       +--NilClass(nil)
     |
     +--[NODE_LASGN]
     |   |
     |   +--Symbol(:v2)
     |   |
     |   +--[NODE_CALL]
     |       |
     |       +--[NODE_LVAR]
     |       |   |
     |       |   +--Symbol(:b)
     |       |
     |       +--Symbol(:upcase)
     |       |
     |       +--NilClass(nil)
     |
     +--[NODE_DSTR]
         |
         +--[NODE_EVSTR]
         |   |
         |   +--[NODE_LVAR]
         |       |
         |       +--Symbol(:v1)
         |
         +--[NODE_ARRAY]
             |
             +--[NODE_STR]
             |   |
             |   +--String(", ")
             |
             +--[NODE_EVSTR]
             |   |
             |   +--[NODE_LVAR]
             |       |
             |       +--Symbol(:v2)
             |
             +--NilClass(nil)
METHOD2_END

  test 'draw AST of a blank proc' do
    graph = Astarisk.draw_graph(RubyVM::AbstractSyntaxTree.of(->(){}))
    assert_equal BLANK_PROC_AST, graph
  end

  test 'draw AST of a blank proc in compact format' do
    graph = Astarisk.draw_graph(RubyVM::AbstractSyntaxTree.of(->(){}), mode: :compact)
    assert_equal BLANK_PROC_COMPACT_AST, graph
  end

  test 'draw AST of a block' do
    graph = Astarisk.draw_graph(RubyVM::AbstractSyntaxTree.of(BLOCK1))
    assert_equal BLOCK1_AST, graph
  end

  test 'draw AST of a method1' do
    graph = Astarisk.draw_graph(RubyVM::AbstractSyntaxTree.of(method(:method1)))
    assert_equal METHOD1_AST, graph
  end

  test 'draw AST of a method2' do
    graph = Astarisk.draw_graph(RubyVM::AbstractSyntaxTree.of(method(:method2)))
    assert_equal METHOD2_AST, graph
  end
end
