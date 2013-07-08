
include Java

require 'sort_performance'

class HeapSort

  attr_reader :sorted

  def setup dataset
    @dataset = dataset
    @sorted = dataset
  end

  def heapsort xs
    ((xs.size - 2) / 2).downto(0) do |start|
      siftdown(xs, start, xs.size - 1)
    end
    (xs.size - 1).downto(1) do |last|
      xs[last], xs[0] = xs[0], xs[last]
      siftdown(xs, 0, last - 1)
    end
    xs
  end

  def siftdown(xs, start, last)
    root = start
    loop do
      child = root * 2 + 1
      break if child > last
      if child + 1 <= last and xs[child] < xs[child + 1]
        child += 1
      end
      if xs[root] < xs[child]
        xs[root], xs[child] = xs[child], xs[root]
        root = child
      else
        break
      end
    end
  end

  def exec
    @sorted = heapsort @dataset
  end

end

ds = DataSet.new
bm = Benchmark.new
sorter = HeapSort.new

production = [10, 100, 1000, 5000, 10000, 100000, 200000, 300000, 400000, 500000, 1000000]
test       = [10, 100, 1000, 10000, 20000, 30000 ]

try = 3

bm.exec sorter, production, [:random], try



