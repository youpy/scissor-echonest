module Scissor
  class Chunk
    def set_delegate(delegate)
      @delegate = delegate
    end

    def method_missing(name, *args, &block)
      @delegate.send(name, *args, &block)
    end
  end
end
