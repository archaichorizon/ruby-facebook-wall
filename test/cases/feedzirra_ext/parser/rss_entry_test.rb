require 'cases/abstract_unit'

class RSSEntryTest < Test::Unit::TestCase
  def test_to_hash_returns_a_hash_containing_the_attributes_of_the_entry
    expected_elements = {'title' => 'Title', 'url' => 'http://example.com/blog_posts/1', 'summary' => 'Lorem ipsum dolor'}

    feed_entry = Feedzirra::Parser::RSSEntry.new
    feed_entry.title = expected_elements['title']
    feed_entry.url = expected_elements['url']
    feed_entry.summary = expected_elements['summary']

    assert_equal expected_elements, feed_entry.to_hash
  end
end