module SLA
  class Checker
    include Colsole

    attr_accessor :max_depth, :checked_links, :check_external, :ignore

    def initialize
      @max_depth = 10
      @checked_links = []
      @check_external = false
      @ignore = []
    end

    def count
      checked_links.count
    end

    def start(link, &block)
      link = Link.new link
      check link, &block
    end

  private

    def check(link, &block)
      return unless validate link, &block

      link.sublinks.each do |sublink|
        validate sublink, &block
      end
      
      if link.depth < max_depth
        link.sublinks.each do |sublink|
          check sublink, &block
        end
      end

      checked_links.push link.ident
    end

    def validate(link, &block)
      return false if skip? link

      link.validate
      yield link if block_given?

      true
    end

    def skip?(link)
      return true if link.external? && !check_external
      return true if checked_links.include? link.ident

      ignore.each do |ignored|
        return true if link.ident.start_with? ignored
      end

      return false
    end

  end
end