module FacebookWall
  module FeedEntryFilters
    class Paragraphizer < FeedEntryFilter
      def apply!(feed_entry)
        plain_paragraphs = Paragraphizer.normalize_line_breaks(feed_entry.summary).split(/(?:<br\/>\s*){2,}/)
        paragraphized = plain_paragraphs.collect{|plain_paragraph| "<p>#{plain_paragraph}</p>"}.join
        feed_entry.summary = paragraphized
      end

      private
  
      def self.normalize_line_breaks(str)
        str.gsub(/<br\s*\/>/, '<br/>')
      end
    end
  end
end