require 'abstract_unit'

class PostTest < Test::Unit::TestCase
  def test_is_initialized_with_a_feed_entry
    feed_entry = create_feed_entry
    post = FacebookWall::Post.new feed_entry

    assert_same feed_entry, post.feed_entry
  end

  def test_decorates_the_feed_entry
    feed_entry = create_feed_entry 'title' => 'Foo', 'description' => 'Bar baz bip'
    post = FacebookWall::Post.new feed_entry

    assert_same feed_entry.title, post.title
    assert_same feed_entry.description, post.description
  end

  #eql?() is added, for testing purposes only, by abstract_unit
  def test_eql_returns_true_if_the_specified_object_is_a_post_with_the_same_value
    attributes = {'title' => 'Item 1 title', 'link' => 'http://example.com/blog_posts/1', 'description' => 'Item 1 description'}

    post = FacebookWall::Post.new create_feed_entry(attributes)
    another_post = FacebookWall::Post.new create_feed_entry(attributes)

    assert post.eql?(another_post)

    almost_a_feed_entry = "<item>\n  <title>Item 1 title</title>\n  <link>http://example.com/blog_posts/1</link>\n  <description>Item 1 description</description>\n</item>"
    post = FacebookWall::Post.new create_feed_entry(attributes)
    
    assert_equal almost_a_feed_entry, post.feed_entry.to_s
    assert ! post.eql?(almost_a_feed_entry)
    
    not_a_post = 123
    post = FacebookWall::Post.new create_feed_entry(attributes)
    
    assert ! post.eql?(not_a_post)
  end
end