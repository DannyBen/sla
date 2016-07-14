module SLA
  class Link
    attr_accessor :text, :url

    def initialize(text, url)
      @text = text
      @url = url
    end

    def path
      uri = URI.parse url
      uri.request_uri
    end
  end
end
