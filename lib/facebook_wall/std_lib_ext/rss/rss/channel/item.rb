module RSS
  class Rss
    class Channel
      class Item
        def eql?(other)
          other.instance_of?(self.class) && to_s.eql?(other.to_s)
        end
      end
    end
  end
end