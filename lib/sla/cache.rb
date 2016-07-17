module SLA
  class Cache
    include Singleton

    def self.get(url)
      instance.cache.get url
    end

    def self.settings
      instance.cache
    end

    def self.life_to_seconds(arg)
      case arg[-1]
      when 's'
        arg[0..-1].to_i
      when 'm'
        arg[0..-1].to_i * 60
      when 'h'
        arg[0..-1].to_i * 60 * 60
      when 'd'
        arg[0..-1].to_i * 60 * 60 * 24
      else
        arg.to_i
      end
    end

    def cache
      @cache ||= cache!
    end

    private
    
    def cache! 
      result = WebCache.new
      result.life = 60 * 60 * 24 # 24 hours
      result
    end
  end
end