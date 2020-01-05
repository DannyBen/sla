class Page
  attr_reader :uri, :parent, :depth

  def initialize(uri, parent: nil, depth: 0)
    if uri.is_a? String
      uri = "http://#{uri}" unless uri.start_with? 'http'
      uri = URI.parse uri
      uri.fragment = false
    end

    @uri, @parent, @depth = uri, parent, depth
  end

  def error
    response.error
  end

  def code
    response.code || 'ERR'
  end

  def external?
    parent ? (uri.host != parent.uri.host) : false
  end

  def inspect
    "#<Page url: #{url}, depth: #{depth}>"
  end

  def pages
    @pages ||= pages!
  end

  def url
    uri.to_s
  end

  def valid?
    !response.error
  end

private

  def anchors
    @anchors ||= dom.css('a[href]')
  end

  def content
    @content ||= response.content
  end

  def dom
    @dom ||= Nokogiri::HTML content
  end

  def normalize_url(new_url)
    new_url = URI.parse new_url
    new_url.fragment = false

    result = new_url.absolute? ? new_url : URI.join(url, new_url)

    result.scheme =~ /^http/ ? result.to_s : nil
  end

  def pages!
    result = {}
    anchors.each do |a|
      url = normalize_url a['href']
      next unless url
      page = Page.new url, parent: self, depth: depth+1
      result[url] = page
    end
    result.values
  end

  def response
    @response ||= response!
  end

  def response!
    response = WebCache.get url
    @uri = response.base_uri
    response
  end

end
