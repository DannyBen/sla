module SLA
  class Checker
    include Colsole

    attr_accessor :checked_links, :max_depth, :next_check

    def initialize
      @max_depth = 10
      @checked_links = []
      @next_check ||= []
    end

    def count
      checked_links.count
    end

    def on_check(urls, depth=1, &block)
      urls = [urls] if urls.is_a? String

      self.next_check = []

      urls.each do |url|
        check_url url, depth, &block
        if depth < max_depth && !next_check.empty?
          on_check next_check, depth+1, &block
        end
      end
    end

    def check_url(url, depth, &_block)
      page = Page.new url, depth: depth
      page.validate

      yield page if block_given? 
      return if depth >= max_depth
      return if checked_links.include? url

      checked_links.push url

      page.links.each do |link|
        next_check.push link.url unless next_check.include? link.url
      end
    end
  end
end