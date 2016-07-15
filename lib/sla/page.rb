module SLA
  class Page
    attr_accessor :depth, :status, :base_uri
    attr_reader :url

    def initialize(url, opts={})
      @url = url
      @base_uri = url
      @status = '000'
      self.depth = opts[:depth] if opts[:depth]
    end

    def valid?
      validate
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

    def content
      @content ||= content!
    end

    def content!
      response = Cache.get url
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
      anchors = doc.css('a')
      result = []
      anchors.each do |a|
        link = Link.new a['href'], text: a.text, parent: base_uri
        result.push link if link.interesting?
      end
      result
    end
  end

end