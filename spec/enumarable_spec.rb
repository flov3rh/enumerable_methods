require_relative '../scripts/enumerable.rb'

RSpec.describe 'Enumerable' do
  it 'goes through all elments in the list and add 1' do
    a = [1,2,3]
    r = []
    a.my_each {|i| r << i + 1}
    expect(r).to eq([2,3,4])

  end

  it 'goes through all elments in the list and times 2' do
    a = [1,2,3]
    r = []
    a.my_each {|i| r << i * 2}
    expect(r).to eq([2,4,6])

  end

  it "returns an enumerable if not passed a block" do
    expect([1,2,3].my_each).to be_a(Enumerable)
  end

  it "returns the sum of all of it's elements recieving a symbol" do
    expect([4, 6 , 8, 10].my_inject(:+)).to eq(28)    
  end
end
