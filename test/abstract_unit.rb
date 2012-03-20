require 'test/unit'

lib = File.expand_path("#{File.dirname(__FILE__)}/../../lib")
$:.unshift(lib) unless $:.include?('lib') || $:.include?(lib)

require 'facebook_wall'

def create_feed(xml)
  RSS::Parser.parse xml
end

def create_feed_entry(attributes = {})
  feed_entry = RSS::Rss::Channel::Item.new

  attributes.each do |name, value|
    feed_entry.send("#{name}=", value)
  end

  feed_entry
end

module FacebookWall
  class Post
    def eql?(other)
      #This will hold for as long as the feed entry is the only source of data
      other.instance_of?(self.class) && feed_entry.to_s.eql?(other.feed_entry.to_s)
    end
  end
end

def create_post(attributes)
  FacebookWall::Post.new create_feed_entry(attributes)
end