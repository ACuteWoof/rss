# RSS Scripts

The scripts here maintain a synced directory where contents from RSS feeds are
downloaded, and offer an interface to browse them through dmenu. You even get notifications!

Please read the scripts before using.

## Example
Here is an example `providers.txt`:
```
0001|https://lewoof.xyz/posts/feed.xml|Vithushan's Posts
0002|https://lewoof.xyz/notes/feed.xml|Vithushan's Notes
```

Below is the corresponding tree of the synced directory, assigned as `STORE`:
```
.
├── 0001
│   ├── 1773997200-lewoof-posts-pgp
│   │   ├── details.md
│   │   └── pgp.html
│   ├── 1776157200-lewoof-posts-rss-feed-info
│   │   ├── details.md
│   │   └── feed.xml
│   ├── feed.xml
│   ├── items.txt
│   └── unprocessed-feed.xml
├── 0002
│   ├── 1776124800-lewoof-feed-further-mechanics
│   │   ├── details.md
│   │   └── mechanics.pdf
│   ├── 1776124800-lewoof-feed-further-pure-1
│   │   ├── details.md
│   │   └── pure-1.pdf
│   ├── 1776124800-lewoof-feed-pure-2-3
│   │   ├── details.md
│   │   └── pure-math-2-3.pdf
│   ├── 1776510000-lewoof-feed-pure-2-3-51e1609349717db598f0b758099ba8b
│   │   ├── 51e1609349717db598f0b758099ba8bc77b400bc
│   │   └── details.md
│   ├── 1776564900-lewoof-feed-further-pure-1-009a0c338e7c1c8564a6c95e8
│   │   ├── 009a0c338e7c1c8564a6c95e840d746e6c8a9e50
│   │   └── details.md
│   ├── feed.xml
│   ├── items.txt
│   └── unprocessed-feed.xml
├── index.txt
└── providers.txt
```

Notification when a new post is downloaded by `update-feed.sh`:

![Notification on dunst](https://git.lewoof.xyz/me/rss/branch/master/tree/assets/notification.png)

Browsing on dmenu (sorted by latest first) by running `browse-rss.sh`:

![Dmenu listing my RSS items](https://git.lewoof.xyz/me/rss/branch/master/tree/assets/dmenu.png)

When opened from dmenu:

![Opened details.md in vim, working directory set correctly by the script](https://git.lewoof.xyz/me/rss/branch/master/tree/assets/open.png)
