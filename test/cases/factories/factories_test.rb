require 'cases/abstract_unit'

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
    <title>Archaic Horizon&apos;s Facebook Wall</title>
    <link>http://www.facebook.com/</link>
    <description>Archaic Horizon&apos;s Facebook Wall</description>
    <item>
      <title><![CDATA[Title 1]]></title>
      <link>http://www.facebook.com/archaichorizon/posts/1</link>
      <description><![CDATA[Description 1]]></description>
    </item>
    <item>
      <title><![CDATA[Title 2]]></title>
      <link>http://www.facebook.com/archaichorizon/posts/2</link>
      <description><![CDATA[Description 2]]></description>
    </item>
  </channel>
</rss>
END

    feed = create_feed(feed_xml)

    feed_entry_filter_chain = FacebookWall::FeedEntryFilters::Chain.new
    posts = FacebookWall::Factories::create_posts feed, feed_entry_filter_chain

    assert posts.instance_of?(Array)
    assert_equal 2, posts.length
    posts.each{|post| assert post.instance_of?(FacebookWall::Post)}

    assert_equal(
      {'title' => 'Title 1', 'url' => 'http://www.facebook.com/archaichorizon/posts/1', 'summary' => 'Description 1'},
      posts.first.to_hash
    )

    assert_equal(
      {'title' => 'Title 2', 'url' => 'http://www.facebook.com/archaichorizon/posts/2', 'summary' => 'Description 2'},
      posts.last.to_hash
    )

    feed_entry_filter_chain = FacebookWall::FeedEntryFilters::Chain.new
    feed_entry_filter_chain << FactoriesTestDoubles::FeedEntryFilter01.new()
    feed_entry_filter_chain << FactoriesTestDoubles::FeedEntryFilter02.new()
    posts = FacebookWall::Factories::create_posts feed, feed_entry_filter_chain

    assert posts.instance_of?(Array)
    assert_equal 2, posts.length
    posts.each{|post| assert post.instance_of?(FacebookWall::Post)}

    assert_equal(
      {'title' => 'Title 1', 'url' => 'http://www.facebook.com/archaichorizon/posts/1', 'summary' => 'Description 1 foo bar'},
      posts.first.to_hash
    )

    assert_equal(
      {'title' => 'Title 2', 'url' => 'http://www.facebook.com/archaichorizon/posts/2', 'summary' => 'Description 2 foo bar'},
      posts.last.to_hash
    )
  end

  #TODO Add to a test helper module?
  def create_feed(xml)
    Feedzirra::Feed.parse(xml){}
  end
end

module FactoriesTestDoubles
  class FeedEntryFilter01 < FacebookWall::FeedEntryFilters::FeedEntryFilter
    def apply!(feed_entry)
      feed_entry.summary << ' foo'
    end
  end
  
  class FeedEntryFilter02 < FacebookWall::FeedEntryFilters::FeedEntryFilter
    def apply!(feed_entry)
      feed_entry.summary << ' bar'
    end
  end
end