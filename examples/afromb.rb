#!/usr/bin/ruby
 
# Re-synthesize song A using the segments of song B.
#
# original
# http://code.google.com/p/echo-nest-remix/source/browse/trunk/examples/afromb/vafroma.py
#
# example result
# http://soundcloud.com/youpy/pocket-calculator-scissor-afroma-mix

require 'rubygems'
require 'scissor/echonest'
require 'narray'
 
class AfromB
  def initialize(a, b = nil)
    @a, @b = [a, b || a]

    @segments_of_a = Scissor(@a).segments
    @segments_of_b = (@a == @b) ? @segments_of_a : Scissor(@b).segments
  end

  def get_distance_from(target)
    dur_weight = 1000
    timbre_weight = 0.001
    pitch_weight = 10
    loudness_weight = 1

    distances = []

    @segments_of_a.each do |segment|
      ddur = (target.duration - segment.duration) ** 2
      dloud = (target.max_loudness.value - segment.max_loudness.value) ** 2

      timbre_diff = NArray.to_na(target.timbre) - segment.timbre
      dtimbre = (timbre_diff ** 2).sum

      pitch_diff = NArray.to_na(target.pitches) - segment.pitches
      dpitch = (pitch_diff ** 2).sum

      distance = dur_weight * ddur +
        loudness_weight * dloud +
        timbre_weight * dtimbre +
        pitch_weight * dpitch;

      distances << distance
    end

    distances
  end

  def run
    result = []

    @segments_of_b.each_with_index do |segment, index|
      distances = get_distance_from(segment)
      distances[index] = 99999.0 if @b == @a
      segment_from_a = @segments_of_a[distances.index(distances.min)]

      if segment_from_a.duration > segment.duration
        result << segment_from_a[0, segment.duration]
      else
        result << segment_from_a + Scissor.silence(segment.duration - segment_from_a.duration)
      end
    end

    Scissor.join(result)
  end
end
 
if __FILE__ == $0
  require 'pit'
 
  Scissor.echonest_api_key = Pit.get('echonest.com', :require => {
      'api_key' => 'your Echo Nest API key'
    })['api_key']
  Scissor::Chunk.echonest.user_agent.send_timeout = 300

  if ARGV.size == 3
    a, b, outfile = ARGV
  else
    a, outfile = ARGV
    b = a
  end

  AfromB.new(a, b).run >> outfile
end
