require 'cases/helper'

class ParagraphizerTest < Test::Unit::TestCase
  def test_is_a_feed_entry_filter
    assert FacebookWall::FeedEntryFilters::Paragraphizer < FacebookWall::FeedEntryFilters::FeedEntryFilter
  end

  def test_apply_paragraphizes_the_summary_in_the_feed_entry
    expected_summary = '<p>First paragraph</p><p>Second paragraph</p><p>Something inserted<br/>by Facebook</p>'

    rss_entry = Feedzirra::Parser::RSSEntry.new
    rss_entry.summary = 'First paragraph<br /> <br /> Second paragraph<br/><br/><br/>Something inserted<br/>by Facebook'

    paragraphizer = FacebookWall::FeedEntryFilters::Paragraphizer.new
    paragraphizer.apply! rss_entry

    assert_equal expected_summary, rss_entry.summary
  end
end