#!/bin/sh

while true
do

  sed "s/^This.*/This page was last updated at: $(date +%H:%M:%S)./" -i /usr/local/apache2/htdocs/index.html

done