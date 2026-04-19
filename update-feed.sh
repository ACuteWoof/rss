PROV="/home/acutewoof/basement/rss/providers.txt"
STORE="/home/acutewoof/basement/rss"
IFS="|"
DELAY=300

while true; do
	while read -r dir url name; do
		provider_dir="$STORE/$dir"
		mkdir -p "$provider_dir"
		cd "$provider_dir"
		wget "$url" -O "unprocessed-feed.xml"
		echo $(tr '\n' ' ' < unprocessed-feed.xml) > feed.xml
		xml sel -T -t -m "//item" -v "link" -o "|" -v "guid" -o "|" -v "pubDate" -o "|" -v "title" -o "|" -v "description" -n feed.xml > items.txt
		while read -r url guid pubDate title description; do
			thedate=$(date -d "$pubDate" +%s)
			thedir="./$thedate-$guid"
			if [ ! -d "./$thedir" ]; then
				mkdir "$thedir"
				cd "$thedir"
				displaydate=$(date -d "$pubDate")
				echo "---\nurl: $url\nguid: $guid\ndate: $pubDate\ndate (local): $displaydate\ntitle: $title\n---\n\n$description" > details.md
				notify-send "New post on $name" "$title\n$displaydate\n\n$description"
				wget "$url"
				cd ..
			fi
		done < items.txt
	done < $PROV

	sleep $DELAY
done
