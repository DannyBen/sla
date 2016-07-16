module SLA
  class Checker
    include Colsole

    attr_accessor :max_depth, :checked_links

    def initialize
      @max_depth = 10
      @checked_links = []
    end

    def count
      checked_links.count
    end

    def check(link, depth=1, &block)
      link = Link.new link, depth: depth if link.is_a? String
      link.validate
      yield link if block_given?

      return if checked_links.include? link.url
      checked_links.push link.url

      return unless link.valid?
      return if depth >= max_depth
      
      link.sublinks.each do |sublink|
        check sublink, depth+1, &block
      end
    end
  end
end