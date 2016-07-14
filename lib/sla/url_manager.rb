module SLA
  class UrlManager < Base
    include Singleton

    attr_reader :uri, :base_url

    def base_url=(url)
      url = "http://#{url}" unless url[0..3] == 'http'
      response = cache.get url
      @base_url = response.base_uri
    end

    def absolute(relative, base=nil)
      return false if relative =~ /^(tel|mailto|#)/
      base ||= base_url
      relative = URI.encode relative
      result = URI.join(base, relative)

      return false unless result.host == base_url.host
      result.to_s
    end
  end
end