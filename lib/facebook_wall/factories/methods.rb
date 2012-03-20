module FacebookWall
  module Factories
    #Creates a filter chain containing instances of all feed-entry filters (subclasses of
    #FacebookWall::FeedEntryFilters::FeedEntryFilter) in FacebookWall::FeedEntryFilters.
    #=== Returns
    #FacebookWall::FeedEntryFilters::Chain
    def self.create_feed_entry_filter_chain
      feed_entry_filters_module = FacebookWall::FeedEntryFilters

      chain = feed_entry_filters_module::Chain.new

      feed_entry_filters_module.constants.each do |name|
        constant = feed_entry_filters_module.const_get name
        chain << constant.new if constant < feed_entry_filters_module::FeedEntryFilter
      end

      chain
    end

    #Creates wall posts from the <tt>item</tt>s in the specified RSS feed.
    #=== Parameters
    #[feed - RSS::Rss] A RSS feed
    #[feed_entry_filter_chain - FacebookWall::FeedEntryFilters::Chain] A filter chain
    #=== Returns
    #Array of FacebookWall::Post objects
    def self.create_posts(feed, feed_entry_filter_chain)
      feed.items.collect do |entry|
        entry_clone = entry.clone  #TODO Remove this?
        feed_entry_filter_chain.apply_filters_to! entry_clone
        FacebookWall::Post.new entry_clone
      end
    end
  end
end