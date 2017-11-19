#!/bin/bash
cd data/images
for i in ./*.jpg
do
    if [ ! -d "./watermarked" ]; then mkdir "./watermarked"; fi
    echo $i
    filename=$(basename "$i")
    convert \
    -filter Lanczos \
    "$i" \
    -set option:filter:filter Lanczos \
    -set option:filter:blur 0.8 \
    -quality 80 \
    ../copyright/copyright_sven.png -gravity SouthEast -geometry +30 -composite \
    "./watermarked/$filename"
done
#    -resize 500x500 \
