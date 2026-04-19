PROV="/home/acutewoof/basement/rss/providers.txt"
INDEX="/home/acutewoof/basement/rss/index.txt"
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
		sed -i 's/\t/ /g' items.txt
		while read -r url guid pubDate title description; do
			thedate=$(date -d "$pubDate" +%s)
			thedir="./$thedate-$guid"
			if [ ! -d "./$thedir" ]; then
				mkdir "$thedir"
				cd "$thedir"
				displaydate=$(date -d "$pubDate")
				echo "This file contains the details about this specific RSS item.\nClosing vim will put you in the directory containing the downloaded content.\nSee the last lines for more.\n\n---\nurl: $url\nguid: $guid\ndate: $pubDate\ndate (local): $displaydate\ntitle: $title\n---\n\n$description\n\n---\n\nYou have to decide what to do with the downloaded content. This script does not automate the opening since malicious programs could be executed through the feeds. Always check the content with a text editor or some other safe method before opening it with its handler." > details.md
				echo "[$thedate] [$name] $title [$displaydate] $description | $(pwd)" >> $INDEX
				notify-send "New post on $name" "$title\n$displaydate\n\n$description"
				wget "$url"
				cd ..
			fi
		done < items.txt
	done < $PROV

	sleep $DELAY
done
