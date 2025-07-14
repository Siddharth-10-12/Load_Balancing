#!/bin/bash

# Directory containing the images
images_dir="./html/images"

# Counter for renaming
counter=1

# Rename all image files in the directory
for file in "$images_dir"/*; do
    if [[ -f "$file" ]]; then
        extension="${file##*.}" # Get the file extension
        mv "$file" "$images_dir/image$counter.$extension"
        counter=$((counter + 1))
    fi
done

echo "All images have been renamed."
