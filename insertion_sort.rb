
include Java

require 'sort_performance'

class InsertionSort

  attr_reader :sorted

  def setup dataset
    @dataset = dataset
    @sorted = dataset
  end

  def exec
    ds = @dataset
    1.upto(ds.size - 1) do |j|
      key = ds[j]
      i = j - 1
      while( i >= 0 && ds[i] > key ) do
        ds[i + 1] = ds[i]
        i = i - 1
      end
      ds[i + 1] = key
    end
    @sorted = ds
  end
end

bm = Benchmark.new
sorter = InsertionSort.new

production = [10, 100, 1000, 5000, 10000, 100000, 200000]
test       = [10, 100, 1000, 10000, 20000, 30000, 40000, 50000, 100000 ]

try = 3

bm.exec sorter, test, [:random, :identical, :asc, :desc], try




