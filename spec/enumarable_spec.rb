# frozen_string_literal: true

require_relative '../scripts/enumerable.rb'

RSpec.describe 'Enumerable' do
  it 'goes through all elments in the list and add 1' do
    a = [1, 2, 3]
    r = []
    a.my_each { |i| r << i + 1 }
    expect(r).to eq([2, 3, 4])
  end

  it 'goes through all elments in the list and times 2' do
    a = [1, 2, 3]
    r = []
    a.my_each { |i| r << i * 2 }
    expect(r).to eq([2, 4, 6])
  end

  it 'returns an enumerable if not passed a block' do
    expect([1, 2, 3].my_each).to be_a(Enumerable)
  end

  it "returns the sum of all of it's elements recieving a symbol" do
    expect([4, 6, 8, 10].my_inject(:+)).to eq(28)
  end

  it 'checks if all the values are integers' do
    expect([1, 2, 3, 4, 1].my_all?(Integer)).to eql(true)
  end

  it 'check if none of the elements in the array are strings' do
    expect([1, 2, 3, 4, 5, 6].my_none?(String)).to eql(true)
  end

  it 'count the number of elemnts in a hash' do
    a = {
      1 => 'Haha',
      2 => 'Hehe',
      3 => 'Hihi',
      4 => 'Hoho'
    }
    expect(a.my_count).to eql(4)
  end

  it 'returns the original indexes of the array' do
    r = []
    [1, 2, 3].my_each_with_index { |_element, index| r << index }
    expect(r).to eql([0, 1, 2])
  end

  it 'returns element bigger then 3' do
    expect([1, 2, 4].my_select { |i| i > 3 }).to eql([4])
  end

  it 'returns true if any in the array' do
    expect([1, 2, 4].my_any? { |i| i > 3 }).to eql(true)
  end
end
