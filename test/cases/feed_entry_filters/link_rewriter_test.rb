require 'cases/abstract_unit'

class LinkRewriterTest < Test::Unit::TestCase
  def test_is_a_feed_entry_filter
    assert FacebookWall::FeedEntryFilters::LinkRewriter < FacebookWall::FeedEntryFilters::FeedEntryFilter
  end

  def test_apply_rewrites_links_in_the_summary_in_the_feed_entry
    expected_summary = '<a href="http://example.com">example.com</a>'
  
    feed_entry = Feedzirra::Parser::RSSEntry.new
    feed_entry.summary = '<a href="http://example.com" target="_blank" onmousedown="doSomething()" rel="nofollow" id="link">example.com</a>'
  
    link_rewriter = FacebookWall::FeedEntryFilters::LinkRewriter.new
    link_rewriter.apply! feed_entry

    assert_equal expected_summary, feed_entry.summary
  end
end