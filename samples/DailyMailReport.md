Daily Mail Report
=================

## Requirements
If you dont have an mail server or your mail server hosted inside docker you can use `sendemail`. 
To install it, simply run:
```bash
sudo apt install sendemail -y
```

## Script
Create a script, call it how you like and change ownership to root, the following is an example of how to use send**e**mail

```bash
#!/bin/bash
sendemail -f hostname@yourserver.tld \
          -t 'admin@yourserver.tld' \
          -u "Report - $(date +%Y-%m-%d)" \
          -s "localhost" \
          -m "Hi Admin,\nhere is your daily report:\n$(report)" \
          -xu "no-reply@yourserver.tld" \
          -xp "<your password>" \
          -o message-charset="utf-8" 
```

## Setup cron job
Simply link that file to `/etc/cron.daily` to run it every day.

If you would like to test the cron simply run `run-parts /etc/cron.daily`.

Thats it. now your server will send you the daily news every day ;)
