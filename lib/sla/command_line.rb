module SLA
  class CommandLine < SuperDocopt::Base
    include Colsole

    version VERSION
    docopt File.expand_path 'docopt.txt', __dir__
    subcommands ['check']

    def before_execute
      WebCache.life = args['--cache']
      WebCache.dir  = args['--cache-dir'] if args['--cache-dir']
      @count, @failed = 0, 0
    end

    def check
      max_depth = args['--depth'].to_i
      url = args['URL']
      ignore = args['--ignore']
      ignore = ignore.split " " if ignore
      check_external = args['--external']

      checker = Checker.new max_depth: max_depth,
        ignore: ignore, check_external: check_external

      execute checker, url
    end

    def execute(checker, url)
      page = Page.new url
      checker.check page do |action, page|
        success = handle action, page
      end

      success = @failed == 0

      color = success ? '!txtgrn!' : '!txtred!'
      say "\n#{color}Checked #{@count} pages with #{@failed} failures"

      unless success  or ENV['SLA_ALLOW_FAILS']
        raise BrokenLinks 
      end
    end

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

    # screen_width = terminal_width
    
    # count = 0
    # failed = 0

    # checker.start start_url do |link|
    #   count += 1

    #   status = link.status
    #   colored_status = color_status status
    #   if status != '200'
    #     failed +=1 
    #     resay "#{colored_status} #{link.ident}"
    #     log.push "#{status}  #{link.ident}" if logfile
    #   end

    #   message = "[#{failed}/#{count} @ #{link.depth}] #{status}"
    #   remaining_width = screen_width - message.size - 4
    #   trimmed_link = link.ident[0..remaining_width]
      
    #   resay "[#{failed}/#{count} @ #{link.depth}] #{colored_status} #{trimmed_link} "

    #   sleep ENV['SLA_SLEEP'].to_f if ENV['SLA_SLEEP']
    # end

    # color = failed > 0 ? '!txtred!' : '!txtgrn!'
    # resay "#{color}Done checking #{count} links with #{failed} failures"

    # if logfile      
    #   logstring = log.join("\n") + "\n"
    #   File.write logfile, logstring
    # end

    # if failed > 0 and !ENV['SLA_ALLOW_FAILS']
    #   raise BrokenLinks 
    # end

  private

    def color_status(status)
      case status
      when '200'
        '!txtgrn!200!txtrst!'
      when '404'
        '!txtred!404!txtrst!'
      else
        # :nocov:
        status
        # :nocov:
      end
    end

  end
end