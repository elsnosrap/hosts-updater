# hosts-updater
This is a shell script which updates your local ```/etc/hosts``` file with the hosts file at [someonewhocares.org](http://someonewhocares.org/hosts/).  It was originally written to run on Linux, but could be easily ported to work on Mac OS X too.

This script can be configured to run on a scheduled basis with ```cron```.  If you do this, I recommend only scheduling it once or twice a week.  The file on someonewhocares.org doesn't change that often, and it's just common courtesy to not flood the server with requests.

###Major thanks to Dan Pollack, the owner of the site, and all the contributors to the file itself.
