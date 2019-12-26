Site Link Analyzer
==================================================

[![Gem Version](https://badge.fury.io/rb/sla.svg)](https://badge.fury.io/rb/sla)
[![Build Status](https://travis-ci.com/DannyBen/sla.svg?branch=master)](https://travis-ci.com/DannyBen/sla)
[![Maintainability](https://api.codeclimate.com/v1/badges/f78192aead8a74535a24/maintainability)](https://codeclimate.com/github/DannyBen/sla/maintainability)

---

SLA is a simple broken links checker, with built in caching.

![SLA Demo](demo/cast.svg "SLA Demo")

Install
--------------------------------------------------

```
$ gem install sla
```


Features
--------------------------------------------------

- Easy to use command line interface.
- Built in caching, to avoid overtaxing the server.
- Show and save list of broken links to a log file.
- Exits with non zero code on failure, for CI integration.


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
    Start checking for broken links on a given domain.
  
Options:
  --depth, -d DEPTH
    Set crawling depth [default: 5].

  --cache, -c LIFE
    Set cache life [default: 1d]. LIFE can be in any of the 
    following formats:
      10  = 10 seconds
      20s = 20 seconds
      10m = 10 minutes
      10h = 10 hours
      10d = 10 days

  --cache-dir DIR
    Set the cache directory.

  --external, -x
    Also check external links.

  --log, -l LOGFILE
    Save errors to log file.

  --ignore, -i URLS
    Specify a list of space delimited URLs to skip.
    URLs that start with the strings in this list will be skipped.

Examples:
  sla check example.com
  sla check example.com -c10m -d10
  sla check example.com --cache-dir my_cache
  sla check example.com --depth 10 --log my_log.log
  sla check example.com --cache 30d
  sla check example.com --ignore "/admin /customer/login"

```
