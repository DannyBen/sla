module SLA
  class CommandLine < SuperDocopt::Base
    include Colsole

    version VERSION
    docopt File.expand_path 'docopt.txt', __dir__
    subcommands ['check']

    def before_execute
      @no_color = args['--no-color']
      @no_log = args['--no-log']
    end

    def check
      $cache = WebCache.new
      checker = Checker.new
      checker.max_depth      = args['--depth'].to_i
      checker.check_external = args['--external']
      $cache.life            = args['--cache']
      $cache.dir             = args['--cache-dir'] if args['--cache-dir']
      logfile                = args['--log']
      start_url              = args['DOMAIN']

      start_url = "http://#{start_url}" unless start_url[0..3] == 'http'

      File.unlink logfile if File.exist? logfile

      count = 1
      failed = 0

      log = []

      checker.check start_url do |link|
        indent = '-' * link.depth

        status = link.status
        colored_status = color_status status
        failed +=1 if status != '200'

        say "#{count} #{colored_status} #{indent} #{link.ident}"
        log.push "#{count} #{status} #{indent} #{link.ident}" unless @no_log
        count += 1
      end

      color = failed > 0 ? '!txtred!' : '!txtgrn!'
      color = "" if @no_color
      say "#{color}Done with #{failed} failures"
      log.push "Done with #{failed} failures" unless @no_log

      File.write logfile, log.join("\n") unless @no_log
    end

    private

    def color_status(status)
      return status if @no_color
      # :nocov:
      case status
      when '200'
        '!txtgrn!200!txtrst!'
      when '404'
        '!txtred!404!txtrst!'
      else
        status
      end
      # :nocov:
    end

  end
end