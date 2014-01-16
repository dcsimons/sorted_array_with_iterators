require 'rspec'
require './sorted_array.rb'

shared_examples "yield to all elements in sorted array" do |method|
    specify do 
      expect do |b| 
        sorted_array.send(method, &b) 
      end.to yield_successive_args(2,3,4,7,9) 
    end
end

describe SortedArray do
  let(:source) { [2,3,4,7,9] }
  let(:sorted_array) { SortedArray.new source }

  describe "iterators" do
    describe "that don't update the original array" do 
      describe :each do
        context 'when passed a block' do
          it_should_behave_like "yield to all elements in sorted array", :each
        end

        it 'should return the array' do
          sorted_array.each {|el| el }.should eq source
        end
      end

      describe :map do
        it 'the original array should not be changed' do
          original_array = sorted_array.internal_arr
          expect { sorted_array.map {|el| el } }.to_not change { original_array }
        end

        it_should_behave_like "yield to all elements in sorted array", :map

        it 'creates a new array containing the values returned by the block' do
          sorted_array.map { |x| x + 1 }.should == [3,4,5,8,10]
        end
      end
    end

    describe "that update the original array" do
      describe :map! do
        it 'the original array should be updated' do
          sorted_array.map! { |x| x*x }.should == [4,9,16,49,81]
        end

        it_should_behave_like "yield to all elements in sorted array", :map!

        it 'should replace value of each element with the value returned by block' do
          sorted_array.map! { |x| x * 2 }.should == [4,6,8,14,18]
        end
      end
    end
  end

  describe :find do

    it "finds the value and returns the value" do
      sorted_array.find { |x| x == 4 }.should == 4
    end

    it "cannot find the value and returns nil" do
      sorted_array.find { |x| x == 10 } == nil
    end

    it "returns the first value for when the boolean is true" do
      sorted_array.find { |x| x > 3 } == 4
    end

  end

  describe :inject do
    it "should sum all of the values in the array" do
      sorted_array.inject { |accumulator, element| accumulator + element }.should == 25
    end

    it "should multiply all of the values in the array" do
      sorted_array.inject { |accumulator, element| accumulator * element }.should == 1512
    end
  end
end
