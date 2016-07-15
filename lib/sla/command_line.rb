module SLA
  class CommandLine < Base
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
        @no_color = args['--color']
        check_domain args
      end
    end

    def check_domain(args)
      checker = Checker.new
      checker.max_depth    = args['--depth'].to_i
      checker.cache.life   = args['--cache'].to_i
      checker.cache.dir    = args['--cache-dir'] if args['--cache-dir']
      url_manager.base_url = args['DOMAIN']

      File.unlink 'log.log' if File.exist? 'log.log'

      count = 1
      failed = 0

      open('log.log', 'a') do |f|
        checker.on_check do |page|
          indent = '-' * page.depth

          status = page.status
          colored_status = color_status status
          failed +=1 if status != '200'

          say    "#{count} #{colored_status} #{indent} #{page.name}"
          f.puts "#{count} #{status} #{indent} #{page.name}"
          count += 1
        end

        color = failed > 0 ? '!txtred!' : '!txtgrn!'
        color = "" if @no_color
        say "#{color}Done with #{failed} failures"
        f.puts "Done with #{failed} failures"
      end

    end

    def color_status(status)
      return status if @no_color
      case status
      when '200'
        '!txtgrn!200!txtrst!'
      when '404'
        '!txtred!404!txtrst!'
      else
        status
      end
    end

  end
end