require 'cases/helper'

class FacebookWallTest < Test::Unit::TestCase
  def test_feed_url_returns_the_url_of_the_wall_feed_for_the_specified_page
    assert_equal 'http://www.facebook.com/feeds/page.php?id=260041833284&format=rss20', FacebookWall::feed_url(260041833284)
  end

  def test_posts_returns_an_array_of_posts
    posts = FacebookWall::posts 260041833284
    assert posts.instance_of?(Array)
    assert posts.length > 0
    assert posts.first.instance_of?(FacebookWall::Post)
  end
end