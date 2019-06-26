class FetchGems
  class << self
    def fetch(url)
      fetch_gems(url)
    end

    def fetch_gems(url)
      file = parse_file(fetch_file(url))
    end

    def fetch_file(url)
    end

    def parse_file
    end
  end
end
