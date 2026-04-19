# RSS Scripts

The scripts here maintain a synced directory where contents from RSS feeds are
downloaded, and offer an interface to browse them through dmenu. You even get notifications!

`xmlstarlet` is required for the `xml` command to work. Other commands in the
scripts are self explanatory.

Read the scripts before using.

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

The script does not open the content file automatically. That was my idea
initially, but blindly running a command like `xdg-open` on content downloaded
from the internet is not a particularly smart thing to do.

To deal with this, the update script creates `details.md` for every new post,
where basic information, the description of the item, and markdown renderings
of any downloaded html files, are stored. In the same directory, the content is
downloaded with `wget` (`yt-dlp` for YouTube links). The user is left to choose
what he wants to do with the file.

When opened from dmenu:

![Opened details.md in vim, working directory set correctly by the script](https://git.lewoof.xyz/me/rss/branch/master/tree/assets/open.png)

---

## Addresses, Links, and Contact

See [https://www.lewoof.xyz#pgp](https://www.lewoof.xyz#pgp) for my PGP key.

- Email: [contact@lewoof.xyz](mailto:contact@lewoof.xyz)
- Matrix: [@woof:matrix.lewoof.xyz](https://matrix.to/#/@woof:matrix.lewoof.xyz)
- XMPP: lewoof@anonlounge.xyz
- Site: [www.lewoof.xyz](https://www.lewoof.xyz)
- Solana: `JDkK2kpBmPm6YyYnLYNHpw8FhKyZ9AQ2CQTqj6BQxFKY`
- Bitcoin (native segwit): `c1qh5m8v9xyd8l4yc7d3qfs5a83rqk3eukcjlw6sh`
- BuyMeACoffee: [acutewoof](https://www.buymeacoffee.com/acutewoof)

---

## License

MIT License

Copyright (c) 2026 Vithushan

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
