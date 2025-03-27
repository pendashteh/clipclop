#!/bin/bash

# ClipClop Clipboard Manager Script
VERSION="0.0.9"

# Configurable data directory with default
DATADIR="${CLIPCLOP_DATADIR:-$HOME/data/clipclop}"

# Ensure required dependencies are installed
check_dependencies() {
    local dependencies=("xclip" "fzf")
    local missing_deps=()

    for dep in "${dependencies[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            missing_deps+=("$dep")
        fi
    done

    if [ ${#missing_deps[@]} -ne 0 ]; then
        echo "Error: Missing dependencies: ${missing_deps[*]}"
        echo "Install them using:"
        for dep in "${missing_deps[@]}"; do
            if [ "$dep" == "xclip" ]; then
                echo "sudo apt-get install xclip"
            elif [ "$dep" == "fzf" ]; then
                echo "sudo apt-get install fzf"
            fi
        done
        exit 1
    fi
}

# Ensure data directory exists
prepare_data_dir() {
    mkdir -p "$DATADIR"
}

# Function to save clipboard content
save_clipboard() {
    local timestamp=$(date +"%Y%m%d_%H%M%S")
    local filename="${DATADIR}/clip_${timestamp}"
    
    xclip -o > "$filename"
}

# Function to browse and manage clipboard history
browse_clipboard() {
    while true; do
        # Select a clipboard entry with filename display
        local selected_file=$(find "$DATADIR" -type f -printf '%T@ %p\n' | sort -nr | cut -d' ' -f2- | \
            sed 's:.*/::' | \
            fzf \
                --preview "cat '$DATADIR/{}'" \
                --preview-window=right:60% \
                --height 80% \
                --layout=reverse \
                --border \
                --header "Select a clipboard entry (ESC to exit)")

        # Exit if no file selected
        if [ -z "$selected_file" ]; then
            return
        fi

        # Prompt for action
        clear
        echo "ClipClop v${VERSION}"
        echo "Selected Clipboard Entry:"
        head -n 5 "$DATADIR/$selected_file"
        echo "..."
        echo ""
        echo "Options:"
        echo "1. Copy to Clipboard"
        echo "2. Save to File"
        echo "3. Back to List"
        echo "4. Exit"
        
        read -p "Choose an option (1-4): " choice

        case $choice in
            1)
                xclip -selection clipboard < "$DATADIR/$selected_file"
                echo "Clipboard restored from $selected_file"
                read -n 1 -s -r -p "Press any key to continue..."
                # This will continue the outer while loop, returning to list
                continue
                ;;
            2)
                read -p "Enter filename to save: " output_file
                if [ -n "$output_file" ]; then
                    cp "$DATADIR/$selected_file" "$output_file"
                    echo "File saved to $output_file"
                    read -n 1 -s -r -p "Press any key to continue..."
                fi
                # This will continue the outer while loop, returning to list
                continue
                ;;
            3)
                # Simply continue to list
                continue
                ;;
            4)
                return
                ;;
            *)
                echo "Invalid option"
                sleep 1
                continue
                ;;
        esac
    done
}

# Main function
main() {
    check_dependencies
    prepare_data_dir

    echo "ClipClop Clipboard Manager v${VERSION}"
    
    # Automatically save current clipboard
    save_clipboard

    # Browse clipboard history
    browse_clipboard
}

# Start the script
main
