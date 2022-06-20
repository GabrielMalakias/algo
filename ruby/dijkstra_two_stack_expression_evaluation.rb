require_relative './linked_stack'

class Eval
  attr_accessor :operators, :values

  def initialize
    @operators = LinkedStack.new
    @values = LinkedStack.new
  end

  def call(expression)
    expression = expression.split('')

    expression.each do |value|
      case value
      when '(', ' '
      when '+', '-', '*', '/'
        @operators.push(value)
      when ')'
        operator = @operators.pop
        last_value = @values.pop

        case operator
        when '+'
          last_value = @values.pop + last_value
        when '-'
          last_value = @values.pop - last_value
        when '*'
          last_value = @values.pop * last_value
        when '/'
          last_value = @values.pop / last_value
        end

        @values.push(last_value)
      else
        @values.push(value.to_i)
      end
    end

    @values.pop
  end
end

expr = '(1 + ((2 + 3) * (4 * 5)))'
puts "Your expression #{expr}"
puts "Evaluates to: #{Eval.new.call(expr)}"
