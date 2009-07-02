require 'scissor'
require 'echonest'

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
      chunks = []
      tmpfile = Pathname.new('/tmp/scissor_echonest_temp_' + $$.to_s + '.mp3')

      scissor = to_file(tmpfile)

      beats = echonest.get_beats(tmpfile)
      beats.inject do |m, beat|
        chunks << self[m.start, beat.start - m.start]
        beat
      end

      chunks
    ensure
      tmpfile.unlink
    end
  end
end
