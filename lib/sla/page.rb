module SLA
  class Page < Base
    attr_accessor :depth, :status, :base_uri
    attr_reader :url

    def initialize(url, opts={})
      @url = url
      @base_uri = url
      @status = '000'
      self.depth = opts[:depth] if opts[:depth]
    end

    def valid?
      content
      status == '200'
    end

    def validate
      content
    end

    def name
      @name ||= name!
    end

    def name!
      uri = URI.parse url
      if uri.request_uri.empty? || uri.request_uri == '/'
        url 
      else
        uri.request_uri
      end
    end

    def protocol
      @protocol ||= protocol!
    end

    def protocol!
      uri = URI.parse url
      uri.scheme
    end

    def content
      @content ||= content!
    end

    def content!
      response = cache.get url
      self.status = response.error ? '404' : '200'
      self.base_uri = response.base_uri
      response.content
    end

    def doc
      @doc ||= Nokogiri::HTML content
    end

    def links
      @links ||= links!
    end

    def links!
      links = doc.css('a')
      result = []
      links.each do |link|
        href = url_manager.absolute link['href'], base_uri
        next unless href
        result.push Link.new link.text, href
      end
      result
    end
  end

end