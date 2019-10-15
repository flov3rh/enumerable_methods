module Enumerable
  def my_each
    for i in 0...(self.size)
      yield self[i]
    end
  end

  #
  # def my_each_with_index
  # end
  #
  # def my_select
  # end
  #
  # def my_all?
  # end
  #
  # def my_any?
  # end
  #
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

array=[(0..9).to_a]

array.my_each do |item|
  puts item
end
