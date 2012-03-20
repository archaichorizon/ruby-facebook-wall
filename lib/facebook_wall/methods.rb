module FacebookWall
  #Returns the URL of the RSS feed for the specified Facebook page's wall.
  #=== Parameters
  #[id - Fixnum] The ID of the Facebook page
  #=== Returns
  #String
  def self.feed_url(id)
    "http://www.facebook.com/feeds/page.php?id=#{id.to_s}&format=rss20"
  end

  #Returns the most recent posts from the specified Facebook page's wall.
  #=== Parameters
  #[id - Fixnum] The ID of the Facebook page
  #=== Returns
  #Array of FacebookWall::Post objects
  def self.posts_by(id)
    feed = RSS::Parser.fetch_and_parse feed_url id
    feed_entry_filter_chain = Factories::create_feed_entry_filter_chain
    Factories::create_posts feed, feed_entry_filter_chain 
  end
end