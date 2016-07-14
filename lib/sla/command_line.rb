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

    def handle(args)
      if args['check']
        @domain     = args['DOMAIN']
        @max_depth  = args['--depth'].to_i
        @cache_life = args['--cache'].to_i
        check_domain
      end
    end

    def check_domain
      checker = Checker.new
      checker.max_depth    = @max_depth
      checker.cache.life   = @cache_life
      url_manager.base_url = @domain

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
        say "#{color}Done with #{failed} failures"
        f.puts "Done with #{failed} failures"
      end

    end

    def color_status(status)
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