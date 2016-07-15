module SLA
  class Base
    attr_accessor :domain

    def cache
      @cache ||= Cache.instance.cache
    end
  end
end