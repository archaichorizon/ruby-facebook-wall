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

    assert posts.first.eql?(create_post('title' => 'Item 1 title', 'link' => 'http://example.com/blog_posts/1', 'description' => 'Item 1 description'))
    assert posts.last.eql?(create_post('title' => 'Item 2 title', 'link' => 'http://example.com/blog_posts/2', 'description' => 'Item 2 description'))

    feed = create_feed feed_xml
    feed_entry_filter_chain = FacebookWall::FeedEntryFilters::Chain.new
    feed_entry_filter_chain << FactoriesTestDoubles::FeedEntryFilter01.new()
    feed_entry_filter_chain << FactoriesTestDoubles::FeedEntryFilter02.new()
    posts = FacebookWall::Factories::create_posts feed, feed_entry_filter_chain

    assert posts.instance_of?(Array)
    assert_equal 2, posts.length
    posts.each{|post| assert post.instance_of?(FacebookWall::Post)}

    assert posts.first.eql?(create_post('title' => 'Item 1 title', 'link' => 'http://example.com/blog_posts/1', 'description' => 'Item 1 description foo bar'))
    assert posts.last.eql?(create_post('title' => 'Item 2 title', 'link' => 'http://example.com/blog_posts/2', 'description' => 'Item 2 description foo bar'))

    feed_xml = <<END
<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0">
  <channel>
    <title>Archaic Horizon&apos;s Facebook Wall</title>
    <link>http://www.facebook.com/</link>
    <description>Archaic Horizon&apos;s Facebook Wall</description>
    <item>
      <title><![CDATA[ More of Jeremy Morgan&#039;s work here: http://jphmorgan.com]]></title>
      <link>http://www.facebook.com/archaichorizon/posts/262512677162510</link>
      <description><![CDATA[More of Jeremy Morgan&#039;s work here: <a href="http://jphmorgan.com/" target="_blank" rel="nofollow nofollow" onmousedown="UntrustedLink.bootstrap($(this), &quot;4AQEEBrT_&quot;, event, bagof(&#123;&#125;));">http://jphmorgan.com/</a><br/><br/><a href="http://27.media.tumblr.com/tumblr_m09mfxU8kE1qdrgo9o9_r8_500.jpg" id="" title="" target="" onclick="" style="" onmousedown="UntrustedLink.bootstrap($(this), &quot;PAQGoceG_&quot;, event, bagof(&#123;&#125;));" rel="nofollow"><img class="img" src="http://external.ak.fbcdn.net/safe_image.php?d=AQDzaFjOqqk40sEl&amp;w=90&amp;h=90&amp;url=http%3A%2F%2F27.media.tumblr.com%2Ftumblr_m09mfxU8kE1qdrgo9o9_r8_500.jpg" alt="" /></a><br/><a href="http://27.media.tumblr.com/tumblr_m09mfxU8kE1qdrgo9o9_r8_500.jpg" id="" target="_blank" style="" onmousedown="UntrustedLink.bootstrap($(this), &quot;eAQE2srCn&quot;, event, bagof(&#123;&#125;));" rel="nofollow"><a href="http://27.media.tumblr.com/tumblr_m09mfxU8kE1qdrgo9o9_r8_500.jpg" target="_blank" rel="nofollow nofollow" onmousedown="UntrustedLink.bootstrap($(this), &quot;yAQFp-Snl&quot;, event, bagof(&#123;&#125;));">http://27.media.tumblr.com/tumblr_m09mfxU8kE1qdrgo9o9_r8_500.jpg</a></a><br/>27.media.tumblr.com]]></description>
    </item>
    <item>
      <title><![CDATA[ A generative ambient sound instrument created by Batuhan Bozkurt, a sound artist...]]></title>
      <link>http://www.facebook.com/archaichorizon/posts/377150222297415</link>
      <description><![CDATA[A generative ambient sound instrument created by Batuhan Bozkurt, a sound artist, computer programmer, performer and overall a curious person currently living in Istanbul, Turkey.<br /> <br /> <a href="http://www.earslap.com/projectslab/circuli?q=2608v4564v1o_2o66564k1k7_2o4o063442262o" target="_blank" rel="nofollow nofollow" onmousedown="UntrustedLink.bootstrap($(this), &quot;CAQHV5LbD&quot;, event, bagof(&#123;&#125;));">http://www.earslap.com/projectslab/circuli?q=2608v4564v1o_2o66564k1k7_2o4o063442262o</a><br/><br/><br/><a href="http://www.earslap.com/projectslab/circuli?q=2608v4564v1o_2o66564k1k7_2o4o063442262o" id="" target="_blank" style="" onmousedown="UntrustedLink.bootstrap($(this), &quot;mAQGmvWic&quot;, event, bagof(&#123;&#125;));" rel="nofollow">Circuli</a><br/>www.earslap.com]]></description>
    </item>
  </channel>
</rss>
END

    feed = create_feed feed_xml
    feed_entry_filter_chain = FacebookWall::Factories::create_feed_entry_filter_chain
    posts = FacebookWall::Factories::create_posts feed, feed_entry_filter_chain

    assert_equal(
      '<p>More of Jeremy Morgan&#039;s work here: <a href="http://jphmorgan.com/">http://jphmorgan.com/</a></p><p><a href="http://27.media.tumblr.com/tumblr_m09mfxU8kE1qdrgo9o9_r8_500.jpg"><img class="img" src="http://external.ak.fbcdn.net/safe_image.php?d=AQDzaFjOqqk40sEl&amp;w=90&amp;h=90&amp;url=http%3A%2F%2F27.media.tumblr.com%2Ftumblr_m09mfxU8kE1qdrgo9o9_r8_500.jpg" alt="" /></a><br/><a href="http://27.media.tumblr.com/tumblr_m09mfxU8kE1qdrgo9o9_r8_500.jpg"><a href="http://27.media.tumblr.com/tumblr_m09mfxU8kE1qdrgo9o9_r8_500.jpg">http://27.media.tumblr.com/tumblr_m09mfxU8kE1qdrgo9o9_r8_500.jpg</a></a><br/>27.media.tumblr.com</p>',
      posts.first.description
    )

    assert_equal(
      '<p>A generative ambient sound instrument created by Batuhan Bozkurt, a sound artist, computer programmer, performer and overall a curious person currently living in Istanbul, Turkey.</p><p><a href="http://www.earslap.com/projectslab/circuli?q=2608v4564v1o_2o66564k1k7_2o4o063442262o">http://www.earslap.com/projectslab/circuli?q=2608v4564v1o_2o66564k1k7_2o4o063442262o</a></p><p><a href="http://www.earslap.com/projectslab/circuli?q=2608v4564v1o_2o66564k1k7_2o4o063442262o">Circuli</a><br/>www.earslap.com</p>',
      posts.last.description
    )
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