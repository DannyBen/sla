module SLA
  module Formatters
    class Verbose < Base
      def handle(action, page)
        case action
        when :source
          say "\n!txtpur!SOURCE  #{page.url}"
        
        when :check
          @count += 1

          if page.valid?
            status = "PASS"
            color = "!txtgrn!"
          else
            @failed += 1
            status = "FAIL"
            color = "!txtred!"
          end

          say "  #{color}#{status}!txtrst!  #{page.depth}  #{page.url}"

        when :skip
          say "  !txtblu!SKIP!txtrst!  #{page.depth}  #{page.url}"

        end
      end
    end
  end
end