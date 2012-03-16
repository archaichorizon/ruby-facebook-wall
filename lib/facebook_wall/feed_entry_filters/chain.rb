module FacebookWall
  module FeedEntryFilters
    class Chain < Array
      def apply_filters_to!(feed_entry)
        each do |feed_entry_filter|
          feed_entry_filter.apply! feed_entry
        end
      end
    end
  end
end