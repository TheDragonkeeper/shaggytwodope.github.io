from datetime import date
import subprocess
from datetime import datetime
import os.path
import email.utils
import time
import feedparser

myanimeurl = 'https://myanimelist.net/rss.php?type=rw&u=shaggytwodope'


_SITEMAP = """<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
%s
</urlset>
"""

_SITEMAP_URL = """
<url>
    <loc>%s/%s</loc>
    <lastmod>%s</lastmod>
    <changefreq>%s</changefreq>
    <priority>%s</priority>
</url>
"""


def hook_preconvert_sitemap():
    """Generate Google sitemap.xml file."""
    date = datetime.strftime(datetime.now(), "%Y-%m-%d")
    urls = []
    for p in pages:
        urls.append(_SITEMAP_URL %
                    (options.base_url.rstrip('/'), p.url, date,
                     p.get("changefreq", "monthly"), p.get("priority", "0.8")))
    fname = os.path.join(options.project, "output", "sitemap.xml")
    fp = open(fname, 'w')
    fp.write(_SITEMAP % "".join(urls))
    fp.close()


_RSS = """<?xml version="1.0"?>
<rss version="2.0">
<channel>
<title>%s</title>
<link>%s</link>
<description>%s</description>
<language>en-us</language>
<pubdate>%s</pubdate>
<lastbuilddate>%s</lastbuilddate>
<docs>http://blogs.law.harvard.edu/tech/rss</docs>
<generator>Poole</generator>
%s
</channel>
</rss>
"""

_RSS_ITEM = """
<item>
    <title>%s</title>
    <link>%s</link>
    <description>%s</description>
    <pubdate>%s</pubdate>
    <guid>%s</guid>
</item>
"""


def hook_postconvert_rss():
    items = []
    posts = [p for p in pages if "post" in p]
    posts.sort(key=lambda p: p.date, reverse=True)
    for p in posts:
        title = p.post
        link = "%s/%s" % (options.base_url.rstrip("/"), p.url)
        desc = p.get("description", "")
        date = time.mktime(time.strptime("%s 12" % p.date, "%Y-%m-%d %H"))
        date = email.utils.formatdate(date)
        items.append(_RSS_ITEM % (title, link, desc, date, link))

    items = "".join(items)

    title = "ShaggyTwoDope's Blog"
    link = "%s/blog.html" % options.base_url.rstrip("/")
    desc = "A simple blog for Johnathan 'ShaggyTwoDope' Jenkins"
    date = email.utils.formatdate()

    rss = _RSS % (title, link, desc, date, date, items)

    fp = open(os.path.join(output, "rss.xml"), 'w')
    fp.write(rss)
    fp.close()


def today():
    return date.today().strftime("%B %d, %Y")


def git_rev():
    return subprocess.check_output(['git', 'rev-parse', '--short', 'HEAD'])


def fortune():
    call = ['fortune']
    fortune = subprocess.check_output(call)
    while (len(fortune) > 50):
        fortune = subprocess.check_output(call)
    fortune = fortune.decode()
    fortune = fortune.strip()
    fortune = fortune.replace("\n", " ")
    return fortune


def myanime():
    feed = feedparser.parse(myanimeurl)
    posts_to_print = []
    for post in feed.entries:
        title = post.title
        posts_to_print.append(title)
    for i, title in enumerate(posts_to_print):
        print(title)
        if(i >= 4):
            break
