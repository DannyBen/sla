module SLA
  module Formatters
    class TTY < Base
      attr_reader :last_source

      def handle(action, page)
        screen_width = terminal_width

        @last_source = page.url if action == :source

        return unless action == :check
        @count += 1

        if page.valid?
          status = "PASS"
          color = "!txtgrn!"
        else
          @failed += 1
          status = "FAIL"
          color = "!txtred!"

          if last_source
            resay "!txtpur!SOURCE  #{last_source}"
            @last_source = nil
          end

          resay "  !txtred!FAIL!txtrst!  #{page.depth}  #{page.url}"
          resay "   !txtred!#{page.code}!txtrst!  #{page.error}" unless page.code == 404
        end

        message = "[#{failed}/#{count} @ #{page.depth}] #{status}"
        remaining_width = screen_width - message.size - 4
        url = page.url[0..remaining_width]
        resay "[#{failed}/#{count} @ #{page.depth}] #{color}#{status}!txtrst! #{url} "
      end

      def footer_prefix
        terminal? ? "\033[2K\n" : "\n"
      end


    end
  end
end