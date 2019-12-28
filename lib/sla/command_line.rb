module SLA
  class CommandLine < SuperDocopt::Base
    include Colsole

    version VERSION
    docopt File.expand_path 'docopt.txt', __dir__
    subcommands ['check']

    def before_execute
      WebCache.life = args['--cache']
      WebCache.dir  = args['--cache-dir'] if args['--cache-dir']
    end

    def check
      checker = Checker.new
      checker.max_depth = args['--depth'].to_i
      logfile = args['--log']
      start_url = args['URL']
      ignore = args['--ignore']
      ignore = ignore.split " " if ignore
      screen_width = terminal_width
      
      checker.check_external = args['--external']
      checker.ignore = ignore if ignore

      start_url = "http://#{start_url}" unless start_url[0..3] == 'http'

      File.unlink logfile if logfile and File.exist? logfile

      count = 0
      failed = 0

      log = []

      checker.start start_url do |link|
        count += 1

        status = link.status
        colored_status = color_status status
        if status != '200'
          failed +=1 
          resay "#{colored_status} #{link.ident}"
          log.push "#{status}  #{link.ident}" if logfile
        end

        message = "[#{failed}/#{count} @ #{link.depth}] #{status}"
        remaining_width = screen_width - message.size - 4
        trimmed_link = link.ident[0..remaining_width]
        
        resay "[#{failed}/#{count} @ #{link.depth}] #{colored_status} #{trimmed_link} "

        sleep ENV['SLA_SLEEP'].to_f if ENV['SLA_SLEEP']
      end

      color = failed > 0 ? '!txtred!' : '!txtgrn!'
      resay "#{color}Done checking #{count} links with #{failed} failures"

      if logfile      
        logstring = log.join("\n") + "\n"
        File.write logfile, logstring
      end

      if failed > 0 and !ENV['SLA_ALLOW_FAILS']
        raise BrokenLinks 
      end
    end

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