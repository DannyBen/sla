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
      max_depth = args['--depth'].to_i
      url = args['URL']
      ignore = args['--ignore']
      ignore = ignore.split " " if ignore
      check_external = args['--external']
      verbose = args['--verbose']

      checker = Checker.new max_depth: max_depth,
        ignore: ignore, check_external: check_external

      formatter = verbose ? Formatters::Verbose.new : Formatters::TTY.new

      execute url, checker, formatter
    end

    def execute(url, checker, formatter)
      page = Page.new url
      checker.check page do |action, page|
        success = formatter.handle action, page
        sleep ENV['SLA_SLEEP'].to_f if ENV['SLA_SLEEP']
      end

      formatter.footer

      unless formatter.success? or ENV['SLA_ALLOW_FAILS']
        raise BrokenLinks
      end
    end
  end
end