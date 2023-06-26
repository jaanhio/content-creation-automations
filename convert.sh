#!/bin/sh

image_dir=$1
conversion_type=$2 # option1. film or option2. cinematic

if [ -z $image_dir ]; then
    echo "Please provide image directory as first argument."
    exit 1
fi

if [ ! -d $image_dir ]; then
    echo "Not a valid directory"
    exit 1
fi

if [ -z $conversion_type ]; then
    echo "conversion_type not set. setting it to default film conversion"
    conversion_type=1
fi

if [ ! $conversion_type -eq 1 ] && [ ! $conversion_type -eq 2 ]; then
    echo "Conversion type must be either 1 or 2"
    exit 1
fi

output_dir="$image_dir-output"

echo "Located $image_dir"
echo "Creating output $output_dir"
mkdir $output_dir

for image in $image_dir/*; do
    echo "Processing $image"
    file_name=$(basename $image)

    if [ $conversion_type -eq 1 ]; then
        magick convert -bordercolor white -border 100 -gravity center -resize 1200x1200 -extent 1200x1200 $image $output_dir/$file_name
    else
        magick convert -gravity center -crop 100%x78% -bordercolor black -border 0%x14.1% $image $output_dir/$file_name
    fi
done