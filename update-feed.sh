PROV="/home/acutewoof/basement/rss/providers.txt"
STORE="/home/acutewoof/basement/rss"
IFS="|"
DELAY=300

while true; do
	while read -r dir url name; do
		provider_dir="$STORE/$dir"
		mkdir -p "$provider_dir"
		cd "$provider_dir"
		wget "$url" -O "feed.xml"
		xml sel -t -m "//item" -v "link" -o "|" -v "guid" -o "|" -v "pubDate" -o "|" -v "title" -n feed.xml > items.txt
		while read -r url guid pubDate; do
			mkdir "$guid"
			cd "$guid"
			echo "$link\n$guid\n$pubDate\n$title" > details.txt
			wget "$url"
			cd ..
		done < items.txt
	done < $PROV

	sleep $DELAY
done
