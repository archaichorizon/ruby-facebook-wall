require 'test/unit'

lib = File.expand_path("#{File.dirname(__FILE__)}/../../lib")
$:.unshift(lib) unless $:.include?('lib') || $:.include?(lib)

require 'facebook_wall'

def create_feed(xml)
  Feedzirra::Feed.parse(xml){}
end

def create_feed_entry(attributes = {})
  feed_entry = Feedzirra::Parser::RSSEntry.new

  attributes.each do |name, value|
    feed_entry.send("#{name}=", value)
  end

  feed_entry
end