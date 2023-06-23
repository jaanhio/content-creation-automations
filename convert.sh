#!/bin/sh

image_dir=$1

if [ -z $image_dir ]; then
    echo "Please provide image directory as first argument."
    exit 1
fi

if [ ! -d $image_dir ]; then
    echo "Not a valid directory"
    exit 1
fi

output_dir="$image_dir-output"

echo "Located $image_dir"
echo "Creating output $output_dir"
mkdir $output_dir

for image in $image_dir/*; do
    echo "Processing $image"
    file_name=$(basename $image)
    magick convert -bordercolor white -border 100 -gravity center -resize 1200x1200 -extent 1200x1200 $image $output_dir/$file_name
done