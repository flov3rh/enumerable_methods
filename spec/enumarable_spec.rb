# frozen_string_literal: true

require_relative '../scripts/enumerable.rb'

RSpec.describe 'Enumerable' do
  describe '#my_each' do
    let (:a) {[1, 2, 3]}
    it 'goes through all elments in the list and add 1' do
      r = []
      a.my_each { |i| r << i + 1 }
      expect(r).to eq([2, 3, 4])
    end

    it 'goes through all elments in the list and times 2' do
      r = []
      a.my_each { |i| r << i * 2 }
      expect(r).to eq([2, 4, 6])
    end

    it 'returns an enumerable if not passed a block' do
      expect([1, 2, 3].my_each).to be_a(Enumerable)
    end
  end


  describe "#my_inject" do
    let(:a){[4, 6, 8, 10].my_inject(:+)}
    it "returns the sum of all of it's elements recieving a symbol" do
      expect(a).to eq(28)
    end
  end

  describe "#my_all" do
    let(:a){[1, 2, 3, 4, 1]}
    it 'checks if all the values are integers' do
      expect(a.my_all?(Integer)).to eql(true)
    end
  end

  describe "my_none?" do
    let(:a){[1, 2, 3, 4, 5, 6]}
    it 'check if none of the elements in the array are strings' do
      expect(a.my_none?(String)).to eql(true)
    end
  end

  describe "#my_count" do
    let(:d) {{
      1 => 'Haha',
      2 => 'Hehe',
      3 => 'Hihi',
      4 => 'Hoho'
    }}
    it 'count the number of elemnts in a hash' do
      expect(d.my_count).to eql(4)
    end
  end

  describe "#my_each_with_index" do
    let(:a){[1,2,3]}
    it 'returns the original indexes of the array' do
      r = []
      a.my_each_with_index { |_element, index| r << index }
      expect(r).to eql([0, 1, 2])
    end
  end

  describe "#my_select" do
    let(:a) {[1,2,4]}
    it 'returns element bigger then 3' do
      expect(a.my_select { |i| i > 3 }).to eql([4])
    end
  end

  describe "my_any?" do
    let(:a){[1,2,4]}
    it 'returns true if any in the array' do
      expect(a.my_any? { |i| i > 3 }).to eql(true)
    end
  end
end
