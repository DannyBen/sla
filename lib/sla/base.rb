module SLA
  class Base
    attr_accessor :domain

    def cache
      @cache ||= Cache.instance.cache
    end

    def url_manager
      @url_manager ||= UrlManager.instance
    end

    def base_url
      url_manager.base_url.to_s
    end
  end
end