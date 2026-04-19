INDEX="/home/acutewoof/basement/rss/index.txt"

sort -r $INDEX | dmenu -i -p 'RSS:' -l 10 | uxterm -e "cd \"$(sed -e "s/.*|//" -e "s/^ \//\//")\" && vim details.md; zsh"
