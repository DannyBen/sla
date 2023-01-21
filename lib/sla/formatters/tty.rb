module SLA
  module Formatters
    class TTY < Base
      attr_reader :last_source, :screen_width

      def handle(action, page)
        @screen_width = terminal_width
        @last_source = page.url if action == :source

        return unless action == :check

        @count += 1

        show_status page
      end

      def footer_prefix
        terminal? ? "\033[2K\n" : "\n"
      end

    private

      def show_status(page)
        if page.valid?
          status = 'PASS'
          color = 'g'
        else
          @failed += 1
          status = 'FAIL'
          color = 'r'

          if last_source
            say "m`SOURCE  #{last_source}`", replace: true
            @last_source = nil
          end

          say "  r`FAIL`  #{page.depth}  #{page.url}", replace: true
          say "   r`#{page.code}`  #{page.error}", replace: true unless page.code == 404
        end

        message = "[#{failed}/#{count} @ #{page.depth}] #{status}"
        remaining_width = screen_width - message.size - 4
        url = page.url[0..remaining_width]
        say "[#{failed}/#{count} @ #{page.depth}] #{color}`#{status}` #{url} ", replace: true
      end
    end
  end
end
