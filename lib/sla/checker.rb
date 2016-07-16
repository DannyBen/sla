module SLA
  class Checker
    include Colsole

    attr_accessor :max_depth, :checked_links #, :next_check

    def initialize
      @max_depth = 10
      @checked_links = []
      # @next_check ||= []
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

    # def check_url(url, depth, &_block)
    #   page = Page.new url, depth: depth
    #   page.validate

    #   yield page if block_given? 
    #   return if depth >= max_depth
    #   return if checked_links.include? url

    #   checked_links.push url

    #   page.links.each do |link|
    #     next_check.push link.url unless next_check.include? link.url
    #   end
    # end
  end
end