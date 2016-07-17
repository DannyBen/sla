module SLA
  class CommandLine
    include Singleton
    include Colsole

    def execute(argv=[])
      doc = File.read File.dirname(__FILE__) + '/docopt.txt'
      begin
        args = Docopt::docopt(doc, argv: argv, version: VERSION)
        handle args
      rescue Docopt::Exit => e
        puts e.message
      end
    end

    private

    def handle(args)
      if args['check']
        @no_color = args['--no-color']
        @no_log = args['--no-log']
        check_domain args
      end
    end

    def check_domain(args)
      checker = Checker.new
      checker.max_depth      = args['--depth'].to_i
      checker.check_external = args['--external']
      Cache.settings.life    = Cache.life_to_seconds args['--cache']
      Cache.settings.dir     = args['--cache-dir'] if args['--cache-dir']
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