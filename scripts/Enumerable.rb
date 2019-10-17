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
    self.my_each {|item|
      select << item if yield item
    }
    return select
  end

  def my_all? #(my_proc=Proc.new { |obj| obj })
    all=true
    for i in 0...self.size
      all=false unless yield self[i]
    end
    return all
  end

  def my_any? #(my_proc=Proc.new { |obj| obj })
    any=false
    for i in 0...self.size
      any=true if yield self[i]
    end
    return any
  end

  # def my_none?
  # end
  #
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
  puts "#{element[index]}: #{index}"
}
puts "-----------------"

puts "my_select"
puts array_num.my_select{ |item| item%2==0}
puts "-----------------"

puts "my_all?"
puts array_num.my_all?{ |item| item>0}
puts "-----------------"

puts "my_any?"
puts array_num.my_any?{ |item| item>0}
puts "-----------------"
