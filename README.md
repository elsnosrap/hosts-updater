# hosts-updater
This is a shell script which updates your local ```/etc/hosts``` file with the hosts file at [someonewhocares.org](http://someonewhocares.org/hosts/).  It was originally written to run on Linux, but could be easily ported to work on Mac OS X too.

This script can be configured to run on a scheduled basis with ```cron```.  If you do this, I recommend only scheduling it once or twice a week.  The file on someonewhocares.org doesn't change that often, and it's just common courtesy to not flood the server with requests.

This branch integrates with the [host-switcher](https://code.google.com/p/host-switcher/) application.

###Major thanks to Dan Pollack, the owner of the site, and all the contributors to the file itself.

# Using the script
Clone this repo.

If you have any entries you'd like to keep in your hosts file, enter those in ```local_hosts```.  The contents of that file will be merged with the hosts file from [someonewhocares.org](http://someonewhocares.org/hosts/).

Make sure ```hosts.sh``` is executable, then run it.  It will generate a log file you can review to see what it did.  It also creates a backup of your old hosts file, called ```old-etc-hosts```.

The script can be easily scheduled with [crontab](http://linux.die.net/man/1/crontab), to automate the process.  **If you do this though, please be courteous and only run it once or twice a week!!**
