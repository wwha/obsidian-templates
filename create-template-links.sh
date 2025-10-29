#!/bin/zsh

# Check if correct number of arguments provided
if (( $# != 2 )); then
    echo "Usage: $0 <source_template_dir> <target_dir>"
    echo "Example: $0 /path/to/templates /path/to/target"
    exit 1
fi

SOURCE_DIR="$1"
TARGET_DIR="$2"

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory '$SOURCE_DIR' does not exist"
    exit 1
fi

# Check if target directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Target directory '$TARGET_DIR' does not exist"
    exit 1
fi

# Find all .md files in source directory (only in template dir) and create symbolic links
for template in $SOURCE_DIR/*.md(.); do
    filename=${template:t}
    target_link="$TARGET_DIR/$filename"
    
    # Check if link already exists
    if [[ -L "$target_link" ]]; then
        echo "Skipping: Link already exists for $filename"
        continue
    fi
    
    # Create symbolic link
    ln -s "$template" "$target_link"
    if (( $? == 0 )); then
        echo "Created link: $target_link -> $template"
    else
        echo "Error: Failed to create link for $filename"
    fi
done

echo "Done creating template links"
