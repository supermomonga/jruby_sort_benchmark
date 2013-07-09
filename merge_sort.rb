
include Java

require 'sort_performance'

class MergeSort

  attr_reader :sorted

  def setup dataset
    @dataset = dataset
    @sorted = dataset
  end

  def mergesort(xs)
    if xs.size <= 1
      return xs
    end
    middle = xs.size / 2
    left = xs[0,middle]
    right = xs[middle..-1]

    left = mergesort(left)
    right = mergesort(right)
    merge(left, right)
  end

  def merge(left, right)
    result = []
    until left.empty? || right.empty?
      if left.first <= right.first
        result << left.shift
      else
        result << right.shift
      end
    end
    unless left.empty?
      result += left
    end
    unless right.empty?
      result += right
    end
    result
  end

  def exec
    @sorted = mergesort @dataset
  end

end

ds = DataSet.new
bm = Benchmark.new
sorter = MergeSort.new

production = [10, 100, 1000, 5000, 10000, 100000, 200000, 300000, 400000, 500000, 1000000]
test       = [10, 100, 1000, 10000, 20000, 30000 ]

try = 3

bm.exec sorter, production, [:identical], try



