#!/bin/sh

PROV="/home/acutewoof/basement/rss/providers.txt"
MDPREFIX="/home/acutewoof/basement/rss/mdprefix.md"
INDEX="/home/acutewoof/basement/rss/index.txt"
STORE="/home/acutewoof/basement/rss"
HTMLTOMD="pandoc -t gfm"
YTDL_BROWSER="chromium"
YTDL_COOKIES="~/.local/share/qutebrowser/webengine"
PDFENGINE="lualatex"
IFS="|"
DMENU_DELIM="|"
DELAY=300

while true; do
	while read -r dir url name; do
		provider_dir="$STORE/$dir"
		mkdir -p "$provider_dir"
		cd "$provider_dir"
		wget "$url" -O "unprocessed-feed.xml"
		echo $(tr '\n' ' ' < unprocessed-feed.xml) > feed.xml
		xml sel -T -t -m "//item" -v "link" -o "$IFS" -v "guid" -o "$IFS" -v "pubDate" -o "$IFS" -v "title" -o "$IFS" -v "description" -n feed.xml > items.txt || xml sel -T -t -m "//item" -v "link" -o "$IFS" -v "guid" -o "$IFS" -v "pubDate" -o "$IFS" -v "title" -o "$IFS No description" -n feed.xml > items.txt
		while read -r url guid pubDate title description; do
			thedate=$(date -d "$pubDate" +%s)
			processedguid=$(echo "$guid" | sed 's|/|-|g')
			thedir="./$thedate-$processedguid"
			if [ ! -d "./$thedir" ]; then
				mkdir "$thedir" || break
				cd "$thedir"
				displaydate=$(date -d "$pubDate")
				echo "$description" > rss-description
				mddesc=$(eval $HTMLTOMD "rss-description")
				shortmddesc=$(echo "$mddesc" | tr '\n' ' ')
				cat "$MDPREFIX" > details.md
				echo "This is a summary and contains the markdown of any HTML files.\n\n---\n\nurl: $url\n\nguid: $guid\n\ndate: $pubDate\n\ndate (local): $displaydate\n\ntitle: $title\n\n---\n\n$mddesc\n" >> details.md
				indexline="[$thedate] [$name] $title [$displaydate] $shortmddesc $DMENU_DELIM $(pwd)" 
				grep -qxF "$indexline" "$INDEX" || echo "$indexline" >> "$INDEX"
				notify-send "New post on $name" "$title\n$displaydate\n\n$mddesc"

				# to download youtube links as videos instead of as a website
				# use more if statements like this to handle downloading from other feeds
				if [ "${url#*https://youtube.com}" != "$url" ]; then
					yt-dlp "$url" --cookies-from-browser "$YTDL_BROWSER:$YTDL_COOKIES"
				# elif your_condition; then your_download
				else
					wget -p -k -H -E -nd --reject js -e robots=off "$url"
				fi
				for htmlfile in *.html; do
					[ -e "$htmlfile" ] || continue
					echo "---\n$htmlfile\n---\n\n$(eval "$HTMLTOMD" "$htmlfile")" >> details.md
				done
				pandoc --embed-resources details.md -V "geometry:margin=1in" -s -o details.pdf --pdf-engine="$PDFENGINE"
				cd ..
			fi
		done < items.txt
	done < $PROV

	sleep $DELAY
done
