require 'cases/abstract_unit'

class ChainTest < Test::Unit::TestCase
  def test_is_an_array
    assert FacebookWall::FeedEntryFilters::Chain < Array
  end

  def test_apply_filters_to_applies_the_filters_to_the_specified_feed_entry
    feed_entry_filter_chain = FacebookWall::FeedEntryFilters::Chain.new
    feed_entry = create_feed_entry 'summary' => 'Description'
    feed_entry_filter_chain.apply_filters_to! feed_entry

    assert_equal 'Description', feed_entry.summary

    feed_entry_filter_chain = FacebookWall::FeedEntryFilters::Chain.new
    feed_entry_filter_chain << ChainTestDoubles::FeedEntryFilter01.new
    feed_entry_filter_chain << ChainTestDoubles::FeedEntryFilter02.new
    feed_entry = create_feed_entry 'summary' => 'Description'
    feed_entry_filter_chain.apply_filters_to! feed_entry

    assert_equal 'Description foo bar', feed_entry.summary
  end

  #TODO Add to a test helper module
  def create_feed_entry(attributes)
    feed_entry = Feedzirra::Parser::RSSEntry.new

    attributes.each do |name, value|
      feed_entry.send("#{name}=", value)
    end

    feed_entry
  end
end

#TODO Write blog post about this
module ChainTestDoubles
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