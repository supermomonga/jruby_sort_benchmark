
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

production = [10, 100, 1000, 5000, 10000, 100000, 200000, 300000, 400000]
test       = [10, 100, 1000, 5000, 10000 ]

test.tap do |scales|
  puts "Random array"
  scales.each do |scale|
    scale = scale * 10
    bm.setup ds.random scale
    bm.bench sorter
  end
  puts "Idential array"
  scales.each do |scale|
    scale = scale * 10
    bm.setup ds.identical scale
    bm.bench sorter
  end
  puts "Asc array"
  scales.each do |scale|
    scale = scale * 10
    bm.setup ds.asc scale
    bm.bench sorter
  end
  puts "Desc array"
  scales.each do |scale|
    scale = scale * 10
    bm.setup ds.desc scale
    bm.bench sorter
  end
end




