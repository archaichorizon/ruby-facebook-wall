module FacebookWall
  class Post
    attr_reader :feed_entry

    def initialize(feed_entry)
      @feed_entry = feed_entry
    end

    def method_missing(method_id)
      feed_entry.send method_id.id2name
    end
  end
end