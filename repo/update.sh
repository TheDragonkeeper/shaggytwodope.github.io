#! /bin/sh

REL_DATE="$(LC_ALL=en_US date -u '+%a, %d %b %Y %H:%M:%S %Z')"
VALID_DATE="Tue, 30 Nov 2038 00:00:00 UTC"
LABEL_NAME="Shaggy's Repo"
ARCHIVE_NAME="sid"
ARCHS="i386 amd64 arm64 armhf all"

dpkg-scanpackages -m . /dev/null > Packages

gzip -9c Packages > Packages.gz

cat > Release <<EOF
Archive: $ARCHIVE_NAME
Origin: Internet
Label: $LABEL_NAME
Architecture: $ARCHS
Date: $REL_DATE
Valid-Until: $VALID_DATE
MD5Sum:
EOF
printf ' '$(md5sum Packages    | cut --delimiter=' ' --fields=1)' %16d Packages\n'  $(wc --bytes Packages    | cut --delimiter=' ' --fields=1) >> Release
printf ' '$(md5sum Packages.gz    | cut --delimiter=' ' --fields=1)' %16d Packages\n'  $(wc --bytes Packages    | cut --delimiter=' ' --fields=1) >> Release
echo "SHA256:" >> Release
printf ' '$(sha256sum Packages    | cut --delimiter=' ' --fields=1)' %16d Packages\n'  $(wc --bytes Packages    | cut --delimiter=' ' --fields=1) >> Release
printf ' '$(sha256sum Packages.gz | cut --delimiter=' ' --fields=1)' %16d Packages.gz' $(wc --bytes Packages.gz | cut --delimiter=' ' --fields=1) >> Release

gpg --armor --detach-sign --output Release.gpg --yes Release

cat > InRelease <<EOF
Archive: $ARCHIVE_NAME
Origin: Internet
Label: $LABEL_NAME
Architecture: $ARCHS
Date: $REL_DATE
Valid-Until: $VALID_DATE
MD5Sum:
EOF
printf ' '$(md5sum Packages    | cut --delimiter=' ' --fields=1)' %16d Packages\n'  $(wc --bytes Packages    | cut --delimiter=' ' --fields=1) >> InRelease
printf ' '$(md5sum Packages.gz    | cut --delimiter=' ' --fields=1)' %16d Packages\n'  $(wc --bytes Packages    | cut --delimiter=' ' --fields=1) >> InRelease
echo "SHA256:" >> InRelease
printf ' '$(sha256sum Packages    | cut --delimiter=' ' --fields=1)' %16d Packages\n'  $(wc --bytes Packages    | cut --delimiter=' ' --fields=1) >> InRelease
printf ' '$(sha256sum Packages.gz | cut --delimiter=' ' --fields=1)' %16d Packages.gz' $(wc --bytes Packages.gz | cut --delimiter=' ' --fields=1) >> InRelease

echo "" >> InRelease
cat Release.gpg >> InRelease

gpg --yes --clearsign -o InRelease Release

