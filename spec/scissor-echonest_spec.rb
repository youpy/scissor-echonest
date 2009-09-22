$:.unshift File.dirname(__FILE__)

require 'spec_helper'

include SpecHelper

describe Scissor do
  it 'should set Echo Nest API key' do
    Scissor.echonest_api_key = 'XXX'

    Scissor::Chunk.echonest_api_key.should eql('XXX')
  end

  it 'should get beats' do
    Scissor.echonest_api_key = 'XXX'

    api = Echonest::Api.new('XXX')
    api.user_agent.stub!(:get_content).and_return(open(fixture('get_beats.xml')).read)

    scissor = Scissor(fixture('sample.mp3'))
    scissor.stub!(:echonest).and_return(api)

    beats = scissor.beats
    beats.size.should eql(385)
    beats[0].should be_an_instance_of(Scissor::Chunk)
    beats[0].duration.should eql(0.35812)
    beats[0].fragments.first.filename.should eql(fixture('sample.mp3'))
    beats[0].confidence.should eql(1.0)
    beats[1].should be_an_instance_of(Scissor::Chunk)
    beats[1].duration.should eql(0.47604)
    beats[1].fragments.first.filename.should eql(fixture('sample.mp3'))
    beats[1].confidence.should eql(0.296)
  end

  it 'should get segments' do
    Scissor.echonest_api_key = 'XXX'

    api = Echonest::Api.new('XXX')
    api.user_agent.stub!(:get_content).and_return(open(fixture('get_segments.xml')).read)

    scissor = Scissor(fixture('sample.mp3'))
    scissor.stub!(:echonest).and_return(api)

    segments = scissor.segments
    segments.size.should eql(830)
    segments[0].should be_an_instance_of(Scissor::Chunk)
    segments[0].duration.should eql(0.30327)
    segments[0].fragments.first.filename.should eql(fixture('sample.mp3'))
    segments[0].start.should eql(0.0)
    segments[0].loudness.time.should eql(0.0)
    segments[0].loudness.value.should eql(-60.0)
    segments[0].max_loudness.time.should eql(0.31347)
    segments[0].max_loudness.value.should eql(-56.818)
    segments[0].pitches.first.should eql(0.835)
    segments[0].timbre.first.should eql(0.079)
  end
end
