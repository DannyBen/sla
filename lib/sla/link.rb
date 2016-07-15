module SLA
  class Link
    attr_accessor :text, :href
    attr_reader :parent

    def initialize(href, opts={})
      @href = href
      @text = opts[:text]
      self.parent = opts[:parent] || @href
    end

    def uri
      @uri ||= URI.parse href
    end

    def parent=(url)
      @parent = url.is_a?(String) ? URI.parse(url) : url
    end

    def path
      uri.request_uri
    end

    def full_uri
      return uri if uri.absolute? || !parent.absolute?
      URI.join parent, href
    end

    def url
      full_uri.to_s
    end

    def external?
      parent.host != full_uri.host
    end

    def interesting?
      !external? && full_uri.scheme =~ /^http/
    end
  end
end
