description: Created a nice repo for my projects.
---
# {{ page.post }} Posted on {{ page.date }}

The repo will be home to a few packages, the example below is for `nixcontrolcenter`.
I will update this post with any info if need be. Maybe find a way to make it simpler.

<pre class="language-c">
sudo apt-add-repository 'deb http://shaggytwodope.github.io/repo ./'
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7086E9CC7EC3233B
sudo apt-key update
sudo apt-get update
sudo apt-get install nixcontrolcenter
</pre>

If you are on Debian, you may need to install a few extra packages.

Debian Wheezy and earlier:
<pre class="language-c">
sudo apt-get install python-software-properties
</pre>

Debian Jessie and later (2014):
<pre class="language-c">
sudo apt-get install software-properties-common
</pre>



If you have any packages you'd like made let me know.
