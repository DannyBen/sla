module SLA
  class Checker < Base
    include Colsole

    attr_accessor :checked_links, :results, :max_depth, :next_check

    def initialize
      @max_depth = 10
      @checked_links = []
      @next_check ||= []
    end

    def count
      checked_links.count
    end

    def on_check(urls=nil, depth=1, &block)
      urls ||= [base_url]

      self.next_check = []

      urls.each do |url|
        check_url url, depth, &block
        if depth < max_depth
          on_check next_check, depth+1, &block
        end
      end
    end

    def check_url(url, depth, &block)
      page = Page.new url, depth: depth, base_url: base_url
      page.validate

      yield page
      return if depth >= max_depth

      page.links.each do |link|
        next if checked_links.include? link.url
        
        checked_links.push link.url
        next_check.push link.url
      end
    end
  end
end