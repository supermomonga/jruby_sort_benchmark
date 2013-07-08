
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

ds = DataSet.new
bm = Benchmark.new
sorter = InsertionSort.new

1.tap do |scale|
  6.times do
    scale = scale * 10
    bm.setup ds.random scale
    bm.bench sorter
  end
end




