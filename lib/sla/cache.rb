module SLA
  class Cache
    include Singleton

    def cache
      @cache ||= cache!
    end
    
    def cache! 
      result = WebCache.new
      result.life = 60 * 60 * 24 # 24 hours
      result
    end
  end
end