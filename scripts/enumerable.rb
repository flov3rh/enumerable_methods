# frozen_string_literal: true

module Enumerable
  def my_each
    i = 0
    while i < size
      yield(self[i])
      i += 1
    end
  end

  def my_each_with_index
    i = 0
    while i < size
      yield(self[i], i)
      i += 1
    end
  end

  def my_select
    select = []
    my_each { |item| select << item if yield item }
    select
  end

  def my_all?
    all = true
    my_each { |item| all = false unless yield item }
    all
  end

  def my_any?
    any = false
    my_each { |item| any = true if yield item }
    any
  end

  def my_none?
    none = true
    my_each { |item| none = false if yield item }
    none
  end

  def my_count(compare = nil)
    count = 0
    if block_given?
      my_each { |item| count += 1 if yield item }
    elsif !compare.nil?
      my_each { |item| count += 1 if item == compare }
    else
      each { |_item| count += 1 }
    end
    count
  end

  def my_map(my_proc = nil)
    map = []
    if my_proc
      my_proc.call
    elsif block_given?
      each { |item| map << yield(item) }
    else
      return to_enum
    end
    map
  end

  def my_inject(param = nil)
    raise 'No block given' unless block_given?

    memo = param ? param : 0
    my_each { |item| memo = yield(memo, item) }
    memo
  end

  def multiply_els(array)
    result = 1
    array.my_inject(result) { |mult, item| result = mult * item }
  end
end

#-------------------------------------------------------------------------------

puts 'Created Array'
array_num = (1..30).to_a
puts array_num.to_s
puts '-----------------'

puts 'my_each'
array_num.my_each do |item|
  puts item
end
puts '-----------------'

puts 'my_each_with_index'
array_num.my_each_with_index do |element, index|
  puts "#{element}: #{index}"
end
puts '-----------------'

puts 'my_select'
puts array_num.my_select(&:even?)
puts '-----------------'

puts 'my_all?'
puts array_num.my_all?(&:negative?)
puts '-----------------'

puts 'my_any?'
puts array_num.my_any?(&Proc.new{ |item| item > 20 })
puts '-----------------'

puts 'my_none?'
puts array_num.my_none?(&Proc.new{ |item| item > 50 })
puts '-----------------'

puts 'my_count with block'
puts array_num.my_count(&Proc.new{ |item| item > 25 })
puts '-----------------'

puts 'my_count with compare arg'
puts array_num.my_count(5)
puts '-----------------'

puts 'my_count with no block'
puts array_num.my_count
puts '-----------------'

puts 'my_map'
puts array_num.my_map(&Proc.new{ |item| item**2 })
puts '-----------------'

puts 'my_map with no block'
puts array_num.my_map
puts '-----------------'

puts 'my_map with proc'
puts array_num.my_map(&Proc.new{ |item| item + 1 })
puts '-----------------'

puts 'my_inject'
puts array_num.my_inject(&Proc.new{ |sum, n| sum + n })
puts '-----------------'

puts 'multiply_els'
puts [2, 4, 5].multiply_els([2, 4, 5])
puts '-----------------'
