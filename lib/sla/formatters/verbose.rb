module SLA
  module Formatters
    class Verbose < Base
      def handle(action, page)
        case action
        when :source
          say "\n!txtpur!SOURCE  #{page.url}"
        
        when :check
          @count += 1

          show_error = false

          if page.valid?
            status = "PASS"
            color = "!txtgrn!"
          else
            @failed += 1
            status = "FAIL"
            color = "!txtred!"
            show_error = page.code != 404
          end

          say "  #{color}#{status}!txtrst!  #{page.depth}  #{page.url}"
          say "   !txtred!#{page.code}!txtrst!  #{page.error}" if show_error

        when :skip
          say "  !txtblu!SKIP!txtrst!  #{page.depth}  #{page.url}"

        end
      end
    end
  end
end