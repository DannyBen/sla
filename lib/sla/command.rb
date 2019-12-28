module SLA
  class Command < MisterBin::Command
    include Colsole

    help "Site Link Analyzer"

    version VERSION

    usage "sla URL [options]"
    usage "sla --help | -h | --version"

    param "URL", "URL to scan"

    option "--depth, -d DEPTH", "Set crawling depth [default: 5]"
    option "--verbose, -v", "Show detailed output"
    option "--simple, -s", "Show simple output of errors only"
    option "--cache, -c LIFE", "Set cache life [default: 1d]. LIFE can be in any of the following formats:\n  10  = 10 seconds\n  20s = 20 seconds\n  10m = 10 minutes\n  10h = 10 hours\n  10d = 10 days"
    option "--cache-dir DIR", "Set the cache directory"
    option "--external, -x", "Also check external links"
    option "--ignore, -i URLS", "Specify a list of space delimited patterns to skip\nURLs that contain any of the strings in this list will be skipped"

    example "sla example.com"
    example "sla example.com -c10m -d10"
    example "sla example.com --cache-dir my_cache"
    example "sla example.com --depth 10"
    example "sla example.com --cache 30d --external"
    example "sla example.com --simple > out.log"
    example "sla example.com --ignore \"/admin /customer/login\""

    environment "SLA_SLEEP", "Set number of seconds to sleep between calls (for debugging purposes)"

    def run
      WebCache.life = args['--cache']
      WebCache.dir  = args['--cache-dir'] if args['--cache-dir']

      max_depth = args['--depth'].to_i
      url = args['URL']
      ignore = args['--ignore']
      ignore = ignore.split " " if ignore
      check_external = args['--external']

      checker = Checker.new max_depth: max_depth,
        ignore: ignore, check_external: check_external

      formatter = if args['--verbose'] 
        Formatters::Verbose.new
      elsif args['--simple']
        Formatters::Simple.new
      else
        Formatters::TTY.new
      end

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