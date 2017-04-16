#!/bin/zsh
packages=("${(@f)$(cat packages.list)}")
localpackages=("${(@f)$(cat localpackages.list)}")

rm -rf ./packages/* 
rm -rf ./x86_64/*

cd packages

for p in $packages;
do
    wget https://aur.archlinux.org/cgit/aur.git/snapshot/$p.tar.gz
    tar -xvf $p.tar.gz
    cd $p
    makepkg --config ../../makepkg.conf && mv *.pkg.tar.xz ../../x86_64
    cd ..
done

cd ..

cd localpackages

for p in $localpackages;
do
    cd $p
    makepkg -c --config ../../makepkg.conf && mv *.pkg.tar.xz ../../x86_64
    cd ..
done



cd ../x86_64/
for package in `ls *.pkg.tar.xz|xargs` ; do
gpg --detach-sign $package
done

cd ..
repo-add -n ./x86_64/shaggyrepo.db.tar.gz ./x86_64/*.tar.xz

rm -rf ./packages/*
