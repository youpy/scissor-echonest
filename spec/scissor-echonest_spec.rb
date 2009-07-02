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
    api.connection.stub!(:request).and_return(open(fixture('get_beats.xml')).read)

    scissor = Scissor(fixture('sample.mp3'))
    scissor.stub!(:echonest).and_return(api)

    beats = scissor.beats
    beats.size.should eql(384)
    beats[0].should be_an_instance_of(Scissor::Chunk)
    beats[0].duration.should eql(0.476)
    beats[0].fragments.first.filename.to_s.should eql(fixture('sample.mp3'))
  end
end
