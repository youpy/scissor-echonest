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
    end

    def echonest
      Echonest(self.class.echonest_api_key)
    end

    def beats
      tempfile_for_echonest do |tmpfile|
        chunks = []
        scissor = to_file(tmpfile, :bitrate => '64k')

        beats = echonest.get_beats(tmpfile)

        if beats.size != 0
          chunk = self[0, beats.first.start]
          beat = Beat.new(beats.first.start, 1.0)
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
      tempfile_for_echonest do |tmpfile|
        scissor = to_file(tmpfile, :bitrate => '64k')

        segments = echonest.get_segments(tmpfile)
        segments.inject([]) do |chunks, segment|
          chunk = self[segment.start, segment.duration]
          chunk.set_delegate(segment)
          chunks << chunk
          chunks
        end
      end
    end

    private

    def tempfile_for_echonest
      tmpfile = Pathname.new('/tmp/scissor_echonest_temp_' + $$.to_s + '.mp3')
      yield tmpfile
    ensure
      tmpfile.unlink
    end
  end
end
