module FacebookWall
  module FeedEntryFilters
    #Builds HTML paragraphs from groups of text separated by multiple +BR+ tags.  For example:
    #  First paragraph<br /> <br /> Second paragraph<br/><br/><br/>Something inserted<br/>by Facebook
    #would be replaced with:
    #  <p>First paragraph</p><p>Second paragraph</p><p>Something inserted<br/>by Facebook</p>
    class Paragraphizer < FeedEntryFilter
      def apply!(feed_entry)
        plain_paragraphs = Paragraphizer.normalize_line_breaks(feed_entry.description).split(/(?:<br\/>\s*){2,}/)
        paragraphized = plain_paragraphs.collect{|plain_paragraph| "<p>#{plain_paragraph}</p>"}.join
        feed_entry.description = paragraphized
      end

      private
  
      def self.normalize_line_breaks(str)
        str.gsub(/<br\s*\/>/, '<br/>')
      end
    end
  end
end