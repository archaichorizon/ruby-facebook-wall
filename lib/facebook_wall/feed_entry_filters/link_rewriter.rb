module FacebookWall
  module FeedEntryFilters
    #Completely rewrites HTML links in <tt>item</tt>s, removing superfluous attributes added by Facebook.  For example,
    #  <a href="http://example.com" target="_blank" onmousedown="doSomething()" rel="nofollow" id="link">example.com</a>
    #would be replaced with: 
    #  <a href="http://example.com">example.com</a>
    class LinkRewriter < FeedEntryFilter
      def apply!(feed_entry)
        feed_entry.description.scan(/<a\s+[^>]+>/).each do |link_tag|
          href_matches = link_tag.match(/\s+(href="[^"]*")/)
          feed_entry.description.gsub! link_tag, "<a #{href_matches[1]}>" if href_matches
        end
      end
    end
  end
end