#!/bin/sh

INDEX="/home/acutewoof/basement/rss/index.txt"
DELIM="|"

# for PDF:
sort -r $INDEX | dmenu -i -p 'RSS:' -l 10 | sed -e "s/.*$DELIM//" -e "s/^ \//\//" | xargs -r -I @ sh -c 'cd @; xdg-open details.pdf || uxterm -e vim details.md ; uxterm'

# for MD:
# sort -r $INDEX | dmenu -i -p 'RSS:' -l 10 | uxterm -e "cd \"$(sed -e "s/.*$DELIM//" -e "s/^ \//\//")\" && vim details.md; zsh"
