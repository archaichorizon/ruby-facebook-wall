module FacebookWall
  module Factories
    def self.create_feed_entry_filter_chain
      feed_entry_filters_module = FacebookWall::FeedEntryFilters

      chain = feed_entry_filters_module::Chain.new

      feed_entry_filters_module.constants.each do |name|
        constant = feed_entry_filters_module.const_get name
        chain << constant.new if constant < feed_entry_filters_module::FeedEntryFilter
      end

      chain
    end

    def self.create_posts(feed, feed_entry_filter_chain)
      feed.items.collect do |entry|
        entry_clone = entry.clone  #TODO Remove this?
        feed_entry_filter_chain.apply_filters_to! entry_clone
        FacebookWall::Post.new(entry_clone)
      end
    end
  end
end