# ruby scripts/Enumerable.rb

module Enumerable
  def my_each
    for i in 0...self.size
      yield(self[i])
    end
  end

  def my_each_with_index
    for i in 0...self.size
      yield(self[i], i)
    end
  end

  def my_select
    select=[]
    self.my_each {|item| select << item if yield item}
    return select
  end

  def my_all? #(my_proc=Proc.new { |obj| obj })
    all=true
    self.my_each {|item| all=false unless yield item}
    return all
  end

  def my_any? #(my_proc=Proc.new { |obj| obj })
    any=false
    self.my_each {|item| any=true if yield item}
    return any
  end

  def my_none? #(my_proc=Proc.new { |obj| obj })
    none=true
    self.my_each { |item| none=false if yield item}
    return none
  end

  def my_count(compare=nil)
    count=0
    if block_given?
      self.my_each { |item| count+=1 if yield item}
    elsif compare!=nil
      self.my_each { |item| count+=1 if item==compare}
    else
      self.each { |item| count+=1}
    end
    return count
  end

  def my_map(my_proc=nil)
    map=[]
    if my_proc
      my_proc.call
    elsif block_given?
      self.each { |item| map << yield(item)}
    else
      return self.to_enum
    end
    return map
  end

  def my_inject(param=nil)
    raise "No block given" unless block_given?
    memo= param ? param : 0
    self.my_each { |item| memo=yield(memo,item)}
    return memo
  end

  def multiply_els(array)
    result=1
    array.my_inject(result) { |mult,item| result=mult*item}
  end

end

#-------------------------------------------------------------------------------

puts "Created Array"
array_num=(1..30).to_a
puts "#{array_num}"
puts "-----------------"

puts "my_each"
array_num.my_each { |item|
  puts item
}
puts "-----------------"

puts "my_each_with_index"
array_num.my_each_with_index { |element,index|
  puts "#{element}: #{index}"
}
puts "-----------------"

puts "my_select"
puts array_num.my_select{ |item| item%2==0}
puts "-----------------"

puts "my_all?"
puts array_num.my_all?{ |item| item<0}
puts "-----------------"

puts "my_any?"
puts array_num.my_any?{ |item| item>20}
puts "-----------------"

puts "my_none?"
puts array_num.my_none?{ |item| item>50}
puts "-----------------"

puts "my_count with block"
puts array_num.my_count{ |item| item>25}
puts "-----------------"

puts "my_count with compare arg"
puts array_num.my_count(5)
puts "-----------------"

puts "my_count with no block"
puts array_num.my_count
puts "-----------------"

puts "my_map"
puts array_num.my_map{ |item| item**2}
puts "-----------------"

puts "my_map with no block"
puts array_num.my_map
puts "-----------------"

puts "my_map with proc"
puts array_num.my_map(&Proc.new{|item| item+1})
puts "-----------------"

puts "my_inject"
puts array_num.my_inject { |sum, n| sum + n }
puts "-----------------"

puts "multiply_els"
puts [2,4,5].multiply_els([2,4,5])
puts "-----------------"
