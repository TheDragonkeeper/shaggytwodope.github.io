
title: Repos
menu-position: 5
---

Some repos I've created.

# Archlinux - Repo

Add these two lines to your /etc/pacman.conf file:
<pre class="language-c">
[shaggyrepo]
Server = https://shaggytwodope.github.io/archrepo/x86_64
</pre>

My packages are signed by my pgp key. This is a required step before
using the repo.
<pre class="language-c">
sudo pacman-key -r 7EC3233B
sudo pacman-key --lsign-key 7EC3233B
</pre>

TODO
<pre class="language-c">
List of software
</pre>


# Debian/Ubuntu - Repo

<pre class="language-c">
sudo apt-add-repository 'deb http://shaggytwodope.github.io/repo ./'
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7086E9CC7EC3233B
sudo apt-key update
sudo apt-get update
sudo apt-get install drive
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


# Ubuntu PPA's

<pre class="language-c">
TODO
</pre>

