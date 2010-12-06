#!/bin/sh
TO=`echo $1 | sed 's/mailto://'`
google-chrome "https://mail.google.com/mail?view=cm&tf=0&to=$TO"
