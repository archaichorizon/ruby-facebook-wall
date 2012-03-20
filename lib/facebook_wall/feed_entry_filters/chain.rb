module FacebookWall
  module FeedEntryFilters
    class Chain < Array
      #Applies the filters in the chain to the specified RSS item.
      #=== Parameters
      #[feed_entry - RSS::Rss::Channel::Item] A RSS item 
      def apply_filters_to!(feed_entry)
        each do |feed_entry_filter|
          feed_entry_filter.apply! feed_entry
        end
      end
    end
  end
end