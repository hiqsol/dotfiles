#!/bin/bash

# Print out 256 colours, with each number printed in its corresponding colour
printable_colours=256

# Print a number dressed in its colour
function print_colour {
    printf "\x1b[38;5;${1}m%3d " "$1"
}

# Starting at $1, print a run of $2 colours
function print_run {
    local i
    for (( i = "$1"; i < "$1" + "$2" && i < printable_colours; i++ )) do
        print_colour "$i"
    done
    printf "  "
}

# Print blocks of colours
function print_blocks {
    start="$1"
    end="$2" # inclusive
    block_cols="$3"
    block_rows="$4"
    blocks_per_line="$5"
    block_length=$((block_cols * block_rows))

    # Print sets of blocks
    for (( i = start; i <= end; i += (blocks_per_line-1) * block_length )) do
        printf "\n" # Space before each set of blocks
        # For each block row
        for (( row = 0; row < block_rows; row++ )) do
            # Print block columns for all blocks on the line
            for (( block = 0; block < blocks_per_line; block++ )) do
                print_run $(( i + (block * block_length) )) "$block_cols"
            done
            (( i += block_cols )) # Prepare to print the next row
            printf "\n"
        done
    done
}

print_run 0 16 # The first 16 colours are spread over the whole spectrum
printf "\n"
print_blocks 16 231 6 6 3 # The bulk of colours are between 16 and 231 inclusive
print_blocks 232 255 12 2 1 # Not 50, but 24 Shades of Grey
