$:.unshift File.dirname(__FILE__)

require 'spec_helper'

include SpecHelper

describe Scissor do
  it 'should set Echo Nest API key' do
    Scissor.echonest_api_key = 'XXX'

    Scissor::Chunk.echonest_api_key.should eql('XXX')
  end

  it 'should get an instance of EchoNest::Api' do
    Scissor.echonest_api_key = 'XXX'

    echonest = Scissor::Chunk.echonest
    echonest.user_agent.send_timeout = 300

    echonest.should be_an_instance_of(Echonest::Api)
    Scissor::Chunk.echonest.user_agent.send_timeout.should eql(300)
  end

  describe 'analysis' do |object|
    before do
      Scissor.echonest_api_key = 'XXX'

      api = Echonest::Api.new('XXX')
      track_methods = Echonest::ApiMethods::Track.new(api)
      api.stub!(:track).and_return(track_methods)
      track_methods.stub!(:analysis).and_return(Echonest::Analysis.new(open(fixture('analysis.json')).read))

      @scissor = Scissor(fixture('sample.mp3'))
      Scissor::Chunk.stub!(:echonest).and_return(api)
    end

    it 'should get bars' do
      bars = @scissor.bars
      bar = bars.first

      bars.size.should eql(80)
      bar.start.should be_close(1.0, 0.1)
      bar.duration.should be_close(1.48, 0.01)
      bar.confidence.should be_close(0.18, 0.01)
    end

    it 'should get beats' do
      beats = @scissor.beats

      beats.size.should eql(324)
      beats[0].should be_an_instance_of(Scissor::Chunk)
      beats[0].start.should eql(0.0)
      beats[0].duration.should eql(0.27661)
      beats[0].fragments.first.filename.should eql(fixture('sample.mp3'))
      beats[0].confidence.should eql(1.0)
      beats[1].should be_an_instance_of(Scissor::Chunk)
      beats[1].start.should eql(0.27661)
      beats[1].duration.should eql(0.36476)
      beats[1].fragments.first.filename.should eql(fixture('sample.mp3'))
      beats[1].confidence.should eql(0.468)
    end

    it 'should get segments' do
      segments = @scissor.segments
      segment = segments.first

      segments.size.should eql(274)
      segment.start.should eql(0.0)
      segment.duration.should eql(0.43909)
      segment.confidence.should eql(1.0)
      segment.loudness.time.should eql(0.0)
      segment.loudness.value.should eql(-60.0)
      segment.max_loudness.time.should eql(0.11238)
      segment.max_loudness.value.should eql(-33.563)
      segment.pitches.size.should eql(12)
      segment.pitches.first.should eql(0.138)
      segment.timbre.size.should eql(12)
      segment.timbre.first.should eql(11.525)
    end
  end
end
