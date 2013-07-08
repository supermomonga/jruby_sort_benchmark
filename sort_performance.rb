# coding: utf-8

include Java

class DataSet

  def random scale
    if !@random_array || @random_array.size != scale
      @random_array = scale.times.map { rand 1..scale }
    end
    @random_array.clone
  end

  def identical scale
    [1] * scale
  end

  def asc scale
    ( 1..scale ).to_a
  end

  def desc scale
    asc(scale).reverse
  end

end

class Benchmark

  attr_accessor :dataset

  def setup dataset
    @dataset = dataset
    @score = 0
  end

  def bench sorter
    sorter.setup @dataset 
    scale = @dataset.size
    @score = 0
    t1 = java.lang.System.nanoTime
    sorter.exec
    t2 = java.lang.System.nanoTime
    @score = t2 - t1
    @score
  end

  def exec sorter, scales, datatypes = [:random, :identical, :asc, :desc], try = 3
    datatypes.each do |datatype|
      puts "#{ datatype } array"
      begin
        scales.each do |scale|
          score = try.times.inject(0) do |total|
            setup DataSet.new.send datatype, scale
            score = bench sorter
            total += score
          end / try
          puts "#{ score / 1000 / 1000 } milli seconds for sorting #{ scale } elements' array."
        end
      rescue
        puts "Error: maybe stack too deep."
      end
    end
  end

end

