$:.unshift File.dirname(__FILE__) + '/../lib/'

require "scissor/echonest"
require "pathname"

module SpecHelper
  def fixture(filename)
    Pathname.new(File.dirname(__FILE__) + '/fixtures/' + filename).realpath
  end
end
