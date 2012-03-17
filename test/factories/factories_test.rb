require 'abstract_unit'

class FactoriesTest < Test::Unit::TestCase
  def test_create_feed_entry_filter_chain_creates_a_chain_containing_all_filters_in_the_feed_entry_filters_module
    feed_entry_filters_module = FacebookWall::FeedEntryFilters

    feed_entry_filter_chain = FacebookWall::Factories::create_feed_entry_filter_chain

    assert feed_entry_filter_chain.instance_of?(feed_entry_filters_module::Chain)
    assert_equal 2, feed_entry_filter_chain.length

    expected_classes = [feed_entry_filters_module::Paragraphizer, feed_entry_filters_module::LinkRewriter]

    feed_entry_filter_chain.each{|feed_entry_filter| assert expected_classes.include?(feed_entry_filter.class)}
  end

  def test_create_posts_creates_an_array_containing_posts
    feed_xml = <<END
<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0">
  <channel>
    <title>Channel title</title>
    <link>http://example.com/</link>
    <description>Channel description</description>
    <item>
      <title><![CDATA[Item 1 title]]></title>
      <link>http://example.com/blog_posts/1</link>
      <description><![CDATA[Item 1 description]]></description>
    </item>
    <item>
      <title><![CDATA[Item 2 title]]></title>
      <link>http://example.com/blog_posts/2</link>
      <description><![CDATA[Item 2 description]]></description>
    </item>
  </channel>
</rss>
END

    feed = create_feed feed_xml

    feed_entry_filter_chain = FacebookWall::FeedEntryFilters::Chain.new
    posts = FacebookWall::Factories::create_posts feed, feed_entry_filter_chain

    assert posts.instance_of?(Array)
    assert_equal 2, posts.length
    posts.each{|post| assert post.instance_of?(FacebookWall::Post)}

    assert posts.first.feed_entry.eql?(create_feed_entry('title' => 'Item 1 title', 'link' => 'http://example.com/blog_posts/1', 'description' => 'Item 1 description'))
    assert posts.last.feed_entry.eql?(create_feed_entry('title' => 'Item 2 title', 'link' => 'http://example.com/blog_posts/2', 'description' => 'Item 2 description'))

    feed_entry_filter_chain = FacebookWall::FeedEntryFilters::Chain.new
    feed_entry_filter_chain << FactoriesTestDoubles::FeedEntryFilter01.new()
    feed_entry_filter_chain << FactoriesTestDoubles::FeedEntryFilter02.new()
    posts = FacebookWall::Factories::create_posts feed, feed_entry_filter_chain

    assert posts.instance_of?(Array)
    assert_equal 2, posts.length
    posts.each{|post| assert post.instance_of?(FacebookWall::Post)}

    assert posts.first.feed_entry.eql?(create_feed_entry('title' => 'Item 1 title', 'link' => 'http://example.com/blog_posts/1', 'description' => 'Item 1 description foo bar'))
    assert posts.last.feed_entry.eql?(create_feed_entry('title' => 'Item 2 title', 'link' => 'http://example.com/blog_posts/2', 'description' => 'Item 2 description foo bar'))
  end
end

module FactoriesTestDoubles
  class FeedEntryFilter01 < FacebookWall::FeedEntryFilters::FeedEntryFilter
    def apply!(feed_entry)
      feed_entry.description << ' foo'
    end
  end
  
  class FeedEntryFilter02 < FacebookWall::FeedEntryFilters::FeedEntryFilter
    def apply!(feed_entry)
      feed_entry.description << ' bar'
    end
  end
end