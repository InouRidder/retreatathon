require 'open-uri'

class FetchGems
  class << self

    def fetch(url)
      fetch_gems(url)
    end

    def base_gems
      @base_gems ||= fetch_base_gems
    end

    private

    def fetch_gems(url)
      begin
        url = url_to_raw_link(url)
        response = fetch_gemfile_text(url)
        gems = text_to_gems(response)
        gems - base_gems | base_gems - gems
      rescue
        puts "URL: #{url} | 404 - Not found"
      end
    end

    def url_to_raw_link(url)
      url.slice! "https://github.com/"
      "https://raw.githubusercontent.com/#{url}/master/Gemfile"
    end

    def text_to_gems(text)
      text.scan(/gem\s+'(\w*)'/).flatten
    end

    def fetch_base_gems
      base_url = 'https://raw.githubusercontent.com/lewagon/rails-templates/master/devise.rb'
      response = fetch_gemfile_text(base_url)
      @base_gems = text_to_gems(response)
    end

    def fetch_gemfile_text(url)
      open(url).read
    end
  end
end

