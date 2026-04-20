#!/bin/sh

INDEX="/home/acutewoof/basement/rss/index.txt"
DELIM="|"

sort -r $INDEX | dmenu -i -p 'RSS:' -l 10 | uxterm -e "cd \"$(sed -e "s/.*$DELIM//" -e "s/^ \//\//")\" && vim details.md; zsh"
