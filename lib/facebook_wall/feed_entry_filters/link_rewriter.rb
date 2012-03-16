module FacebookWall
  module FeedEntryFilters
    class LinkRewriter < FeedEntryFilter
      def apply!(feed_entry)
        feed_entry.summary.scan(/<a\s+[^>]+>/).each do |link_tag|
          href_matches = link_tag.match(/\s+(href="[^"]*")/)
          feed_entry.summary.gsub! link_tag, "<a #{href_matches[1]}>" if href_matches
        end
      end
    end
  end
end