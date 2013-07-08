
include Java

require 'sort_performance'

class QuickSort

  attr_reader :sorted

  def setup dataset
    @dataset = dataset
    @sorted = dataset
  end

  def swap xs, a, b
    tmp = xs[a]
    xs[a] = xs[b]
    xs[b] = tmp
  end

  def quicksort xs, p, r
    if p < r
      q = partition(xs, p, r)
      quicksort(xs, p, q - 1)
      quicksort(xs, q + 1, r)
    end
  end

  def partition xs, p, r
    x = xs[r]
    i = p - 1
    p.upto(r - 1) do |j|
      if xs[j] <= x
        i += 1
        swap(xs, i, j)
      end
    end
    swap(xs, i + 1, r)
    return i + 1
  end

  def exec
    @sorted = quicksort(@dataset, 0, @dataset.size - 1)
  end
end

ds = DataSet.new
bm = Benchmark.new
sorter = QuickSort.new

production = [10, 100, 1000, 5000, 10000, 100000, 200000, 300000, 400000, 500000, 1000000]
test       = [10, 100, 1000, 10000, 20000, 30000 ]

try = 3

production.tap do |scales|
  [:random, :identical, :asc, :desc].each do |datatype|
    puts "#{ datatype } array"
    begin
      scales.each do |scale|
        score = try.times.inject(0) do |total|
          bm.setup ds.send datatype, scale
          score = bm.bench sorter
          total += score
        end / try
        puts "#{ score / 1000 / 1000 } milli seconds for sorting #{ scale } elements' array."
      end
    rescue
      puts 'Error: Maybe stack over flow.'
    end
  end
end




