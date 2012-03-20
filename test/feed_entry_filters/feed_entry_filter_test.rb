require 'abstract_unit'

class FeedEntryFilterTest < Test::Unit::TestCase
  def test_has_an_instance_method_called_apply
    assert FacebookWall::FeedEntryFilters::FeedEntryFilter.new.respond_to?(:apply!)
  end
end