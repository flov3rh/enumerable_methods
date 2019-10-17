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
    self.each { |item| none=false if yield item}
    return none
  end

  # def my_count
  # end
  #
  # def my_map
  # end
  #
  # def my_inject
  # end
end

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
