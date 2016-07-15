Testing
==================================================

Run tests with:

    $ bundle exec run spec

To run a single spec file only, run something like:

    $ bundle exec run spec page


Mock Server
--------------------------------------------------

The tests run against a `localhost:3000` server which serves as a mock.

Before testing, execute `run server` to start the mock server.

The tests are built so they can also run on remote (CI) build servers.
In this case, they will simply use the cached version of the responses.

The tests that rely on the mock server check if the file `mock.pid` 
exists. If it does, they will run without cache (and cache the 
responses).

Pre-Deployment Steps
--------------------------------------------------

```
$ run flush          # clear the cache folders
$ run server         # start the server if not already running
$ run spec           # test against server, and create cache
$ run server stop    # stop the server
$ run spec           # run against cache, ensure its working
```
