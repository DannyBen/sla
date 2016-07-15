Site Link Analyzer
==================================================

[![Gem](https://img.shields.io/gem/v/sla.svg?style=flat-square)](https://rubygems.org/gems/sla)
[![Travis](https://img.shields.io/travis/DannyBen/sla.svg?style=flat-square)](https://travis-ci.org/DannyBen/sla)
[![Code Climate](https://img.shields.io/codeclimate/github/DannyBen/sla.svg?style=flat-square)](https://codeclimate.com/github/DannyBen/sla)
[![Gemnasium](https://img.shields.io/gemnasium/DannyBen/sla.svg?style=flat-square)](https://gemnasium.com/DannyBen/sla)

---

SLA is a simple broken links checker, with built in caching.

---

Install
--------------------------------------------------

```
$ gem install sla
```

Or with bundler:

```ruby
gem 'sla'
```


Features
--------------------------------------------------

- Easy to use command line interface
- Built in caching, to avoid over stressing the server
- Outputs the site tree to screen and log file


Example Output
--------------------------------------------------
```
$ sla check localhost:3000
1 200 - http://localhost:3000
2 200 -- /whiskey
3 200 --- /whiskey/tango
4 404 ---- /whiskey/tango/foxtrot
5 200 -- /ten
6 200 --- /ten/four
7 200 -- /roger
Done with 1 failures
```


Usage
--------------------------------------------------

```
$ sla --help
SLA

Usage:
  sla check DOMAIN [options]
  sla (-h|--help|--version)

Commands:
  check
    Start checking for broken links on a given domain

Options:
  --depth, -d DEPTH
    Set crawling depth [default: 5]

  --cache, -c LIFE
    Set cache life in seconds [default: 86400]

  --cache-dir DIR
    Set the cache directory

  --no-color
    Disable colors in output

  --no-log
    Disable logging

  --log LOGFILE
    Set the name of the logfile [default: sla.log]

Examples:
  sla check example.com
  sla check example.com -c360 -d10
  sla check example.com --cache-dir my_cache --no-log
  sla check example.com --depth 10 --log my_log.log
```
