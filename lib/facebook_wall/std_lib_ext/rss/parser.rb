#TODO Blog post
module RSS
  class Parser
    #Fetches, and then parses, the RSS feed at the specified URL
    #=== Parameters
    #[url - String] The URL of the RSS feed
    #=== Returns
    #RSS::Rss
    def self.fetch_and_parse(url)
      open url do |http|
        RSS::Parser.parse http.read
      end
    end
  end
end