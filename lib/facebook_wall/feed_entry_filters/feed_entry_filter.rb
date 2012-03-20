module FacebookWall
  module FeedEntryFilters
    class FeedEntryFilter
      #Applies the filter to the specified RSS item.  This method should be overridden in subclasses.
      #=== Parameters
      #[feed_entry - RSS::Rss::Channel::Item] A RSS item 
      def apply!(feed_entry); end
    end
  end
end