module RSS
  class Parser
    def self.fetch_and_parse(url)
      open url do |http|
        RSS::Parser.parse http.read
      end
    end
  end
end