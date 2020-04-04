module SLA
  class Checker
    attr_reader :max_depth, :ignore, :check_external

    def initialize(max_depth: 5, ignore: nil, check_external: false)
      @max_depth = max_depth
      @ignore = ignore
      @check_external = check_external
    end

    def check(page, &block)
      return if skip? page

      yield [:source, page] if block_given?

      pages = page_list page

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

    def page_list(page)
      if check_external
        page.pages
      else
        page.pages.reject { |page| page.external? }
      end
    end

    def skip?(page)
      ignore?(page) or page.depth >= max_depth or !page.valid?
    end

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

