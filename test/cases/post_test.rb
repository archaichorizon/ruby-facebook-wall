require 'cases/abstract_unit'

class PostTest < Test::Unit::TestCase
  def test_is_initialized_with_a_feed_entry
    feed_entry = create_feed_entry
    post = FacebookWall::Post.new feed_entry

    assert_same feed_entry, post.feed_entry
  end

  def test_decorates_the_feed_entry
    feed_entry = create_feed_entry 'title' => 'Foo', 'summary' => 'Bar baz bip'
    post = FacebookWall::Post.new feed_entry

    assert_same feed_entry.title, post.title
    assert_same feed_entry.summary, post.summary
  end
end