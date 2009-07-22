module Scissor
  module Echonest
    module Meta
      module Beat
        def self.init(obj, beat)
          obj.extend self
          obj.instance_eval {
            @confidence = beat.confidence
            @start = beat.start
          }
        end

        attr_reader :confidence, :start
      end

      module Segment
        def self.init(obj, segment)
          obj.extend self
          obj.instance_eval {
            @start = segment.start
            @loudness = segment.loudness
            @max_loudness = segment.max_loudness
            @pitches = segment.pitches
            @timbre = segment.timbre
          }
        end

        attr_reader :start, :loudness, :max_loudness, :pitches, :timbre
      end
    end
  end
end
