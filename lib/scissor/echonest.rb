require 'scissor'
require 'echonest'
require 'scissor/echonest/chunk_ext.rb'

module Scissor
  def self.echonest_api_key=(echonest_api_key)
    Scissor::Chunk.echonest_api_key = echonest_api_key
  end

  class Chunk
    class << self
      attr_accessor :echonest_api_key

      def echonest
        @echonest ||= Echonest(echonest_api_key)
      end
    end

    def bars
      analyze do |analysis|
        bars = analysis.bars
        bars.inject([]) do |chunks, bar|
          chunk = self[bar.start, bar.duration]
          chunk.set_delegate(bar)
          chunks << chunk
          chunks
        end
      end
    end

    def beats
      analyze do |analysis|
        chunks = []
        beats = analysis.beats

        if beats.size != 0
          chunk = self[0, beats.first.start]
          beat = Beat.new(0.0, beats.first.start, 1.0)
          chunk.set_delegate(beat)
          chunks << chunk
        end

        beats.inject do |m, beat|
          chunk = self[m.start, beat.start - m.start]
          chunk.set_delegate(m)
          chunks << chunk
          beat
        end

        chunks
      end
    end

    def segments
      analyze do |analysis|
        segments = analysis.segments
        segments.inject([]) do |chunks, segment|
          chunk = self[segment.start, segment.duration]
          chunk.set_delegate(segment)
          chunks << chunk
          chunks
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
