# frozen_string_literal: true

# rubocop:disable Metrics/ModuleLength

module Enumerable
  def my_each
    return to_enum unless block_given?

    i = 0
    while i < size
      yield(self[i])
      i += 1
    end
  end

  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    while i < size
      yield(self[i], i)
      i += 1
    end
  end

  def my_select
    return to_enum unless block_given?

    select = []
    my_each { |item| select << item if yield item }
    select
  end

  def my_all?(pattern = nil)
    all = true
    if block_given?
      my_each { |item| all = false unless yield item }
    elsif pattern
      # rubocop:disable Style/CaseEquality
      my_each { |item| all = false unless pattern === item }
    else
      my_each { |item| all = false unless item }
    end
    all
  end

  def my_any?(pattern = nil)
    any = false
    if block_given?
      my_each { |item| any = true if yield item }
    elsif pattern
      my_each { |item| any = true if pattern === item }
    else
      my_each { |item| any = true if item }
    end
    any
  end

  def my_none?(pattern = nil)
    none = true
    if block_given?
      my_each { |item| none = false if yield item }
    elsif pattern
      my_each { |item| none = false if pattern === item }
      # rubocop:enable Style/CaseEquality
    else
      my_each { |item| none = false if item }
    end
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

  # rubocop:disable Metrics/PerceivedComplexity
  # rubocop:disable Metrics/CyclomaticComplexity
  def my_inject(*args)
    raise 'no block_given' if !block_given? && args.nil?

    memo = args[0] || self[0]
    if block_given? && args.empty?
      my_each_with_index do |item, index|
        next if index.zero?

        memo = yield(item, memo)
      end
    elsif block_given? && args[0]
      memo = self[0]
      my_each_with_index do |item, index|
        next if index.zero?

        memo = yield(item, memo)
      end
    elsif args[0].is_a? Symbol
      memo = self[0]
      my_each_with_index do |item, index|
        next if index.zero?
        
        memo = memo.send(args[0], item)
      end
    else
      memo = args[0]
      my_each_with_index do |item, _index|
        memo = memo.send(args[1], item)
      end
    end
    memo
  end
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity
end
# rubocop:enable Metrics/ModuleLength
