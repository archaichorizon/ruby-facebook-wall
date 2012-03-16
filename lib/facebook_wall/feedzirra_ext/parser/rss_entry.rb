module Feedzirra
  module Parser
    class RSSEntry
      def to_hash
        hash = {}
        each{|name, value| hash[name] = value}
        hash
      end
    end
  end
end