require 'scissor'
require 'echonest'
require 'scissor/echonest/tape_ext.rb'

module Scissor
  def self.echonest_api_key=(echonest_api_key)
    Scissor::Tape.echonest_api_key = echonest_api_key
  end

  class Tape
    class << self
      attr_accessor :echonest_api_key

      def echonest
        @echonest ||= Echonest(echonest_api_key)
      end
    end

    def bars
      analyze do |analysis|
        bars = analysis.bars
        bars.inject([]) do |tapes, bar|
          tape = self[bar.start, bar.duration]
          tape.set_delegate(bar)
          tapes << tape
          tapes
        end
      end
    end

    def beats
      analyze do |analysis|
        tapes = []
        beats = analysis.beats

        if beats.size != 0
          tape = self[0, beats.first.start]
          beat = Beat.new(0.0, beats.first.start, 1.0)
          tape.set_delegate(beat)
          tapes << tape
        end

        beats.inject do |m, beat|
          tape = self[m.start, beat.start - m.start]
          tape.set_delegate(m)
          tapes << tape
          beat
        end

        tapes
      end
    end

    def segments
      analyze do |analysis|
        segments = analysis.segments
        segments.inject([]) do |tapes, segment|
          tape = self[segment.start, segment.duration]
          tape.set_delegate(segment)
          tapes << tape
          tapes
        end
      end
    end

    private

    def analyze
      tmpfile = Pathname.new('/tmp/scissor_echonest_temp_' + $$.to_s + '.mp3')
      scissor = to_file(tmpfile, :bitrate => '64k')

      yield self.class.echonest.track.analysis(tmpfile)
    ensure
      tmpfile.unlink if tmpfile.exist?
    end
  end
end
