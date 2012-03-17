require 'abstract_unit'

class ParserTest < Test::Unit::TestCase
  def test_fetch_and_parse_fetches_and_parses_the_feed_at_the_specified_url
    feed = RSS::Parser.fetch_and_parse 'http://www.facebook.com/feeds/page.php?id=260041833284&format=rss20'
    assert feed.instance_of?(RSS::Rss)
    assert feed.items.length > 0
  end
end