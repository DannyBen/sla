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
    Set the cache directory [default: cache]

  --color
    Disable colors in output

Examples:
  sla check example.com
  sla check example.com -c360 -d10
```
