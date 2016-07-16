module SLA
  class Link
    attr_accessor :text, :href, :status, :depth, :real_uri
    attr_reader :parent

    def initialize(href, opts={})
      @href         = href
      @text         = opts[:text]
      @depth        = opts[:depth] || 1
      self.parent   = opts[:parent] || @href
    end

    def valid?
      validate
      status == '200'
    end

    def validate
      content
    end

    def content
      @content ||= content!
    end

    def content!
      response = Cache.get url
      self.status = response.error ? '404' : '200'
      self.real_uri = response.base_uri
      response.content
    end

    def ident
      full_uri.request_uri
    end

    def url
      full_uri.to_s
    end

    def doc
      @doc ||= Nokogiri::HTML content
    end

    def sublinks
      @sublinks ||= sublinks!
    end

    def sublinks!
      anchors = doc.css('a')
      result = []
      anchors.each do |a|
        link = Link.new a['href'], text: a.text, parent: real_uri, depth: depth+1
        result.push link if link.interesting?
      end
      result
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

    def external?
      parent.host != full_uri.host
    end

    def interesting?
      !external? && full_uri.scheme =~ /^http/
    end
  end
end
