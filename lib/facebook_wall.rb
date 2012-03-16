require 'feedzirra'

require 'facebook_wall/feedzirra_ext/parser/rss_entry'  #TODO Create feedzirra_ext.rb and include that instead?
require 'facebook_wall/methods'
require 'facebook_wall/version'
require 'facebook_wall/post'
require 'facebook_wall/feed_entry_filters/feed_entry_filter'
require 'facebook_wall/feed_entry_filters/paragraphizer'
require 'facebook_wall/feed_entry_filters/link_rewriter'
require 'facebook_wall/feed_entry_filters/chain'
require 'facebook_wall/factories/methods'

#module FacebookWall
#end