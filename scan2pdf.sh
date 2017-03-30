#!/bin/bash

OUTPUT_DIR=~/Documents/scans
TEMP_DIR=/tmp/scan

pages=$1
counter=0

if [ -z $pages ] || [ $pages -lt 1 ]; then
  pages=1
fi

mkdir -p $TEMP_DIR > /dev/null
mkdir -p $OUTPUT_DIR > /dev/null

echo "Scanning: $pages pages..."
while [ $pages -gt $counter ]; do
  counter=$[counter + 1]
  echo -e "\r\tpage $counter/$pages"
  scanimage -p  --format=tiff > $TEMP_DIR/img_$counter.tiff
done

echo "Converting to pdf..."
tiffcp $TEMP_DIR/*.tiff  $TEMP_DIR/all.tiff
tiff2pdf -z -f -c "$(git config --global user.name)" -o $OUTPUT_DIR/scan_$(date +%s).pdf $TEMP_DIR/all.tiff

rm -rf /tmp/scan

echo Done.
