require 'cases/abstract_unit'

class ItemTest < Test::Unit::TestCase
  def test_eql_returns_true_if_the_specified_object_is_an_item_with_the_same_value
    attributes = {'title' => 'Item 1 title', 'link' => 'http://example.com/blog_posts/1', 'description' => 'Item 1 description'}
    feed_entry = create_feed_entry attributes

    another_feed_entry = create_feed_entry attributes

    assert feed_entry.eql?(another_feed_entry)

    almost_a_feed_entry = "<item>\n  <title>Item 1 title</title>\n  <link>http://example.com/blog_posts/1</link>\n  <description>Item 1 description</description>\n</item>"

    assert_equal almost_a_feed_entry, feed_entry.to_s
    assert ! feed_entry.eql?(almost_a_feed_entry)

    not_a_feed_entry = 123

    assert ! feed_entry.eql?(not_a_feed_entry)
  end
end