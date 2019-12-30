module SLA
  class Checker
    attr_reader :max_depth, :ignore, :check_external

    def initialize(max_depth: 5, ignore: nil, check_external: false)
      @max_depth = max_depth
      @ignore = ignore
      @check_external = check_external
    end

    def check(page, &block)
      return if ignore? page
      return if page.depth >= max_depth
      return unless page.valid?

      yield [:source, page] if block_given?

      pages = page.pages
      pages.reject! { |page| page.external? } if !check_external

      pages.each do |page|
        if checked.has_key? page.url or ignore? page
          yield [:skip, page] if block_given?
        else
          checked[page.url] = true
          yield [:check, page] if block_given?
        end
      end

      pages.each do |page|
        next if deeply_checked.has_key? page.url
        deeply_checked[page.url] = true
        next if page.external?
        check page, &block
      end
    end

  private

    def ignore?(page)
      return false unless ignore

      ignore.each do |text|
        return true if page.url.include? text
      end

      false
    end

    def deeply_checked
      @deeply_checked ||= {}
    end

    def checked
      @checked ||= {}
    end

  end
end

