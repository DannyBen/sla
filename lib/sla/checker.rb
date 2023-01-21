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

      yield [:source, page] if block

      pages = page_list page

      pages.each do |next_page|
        if checked.has_key?(next_page.url) || ignore?(next_page)
          yield [:skip, next_page] if block
        else
          checked[next_page.url] = true
          yield [:check, next_page] if block
        end
      end

      pages.each do |next_page|
        next if deeply_checked.has_key? next_page.url

        deeply_checked[next_page.url] = true
        next if next_page.external?

        check next_page, &block
      end
    end

  private

    def page_list(page)
      if check_external
        page.pages
      else
        page.pages.reject(&:external?)
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
