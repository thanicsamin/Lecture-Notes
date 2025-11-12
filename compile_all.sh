#!/bin/bash

# --- Configuration ---
# Set the command you want to use for compilation.
# 'pdflatex' is standard. 'xelatex' or 'lualatex' might be needed for certain files.
LATEX_COMMAND="pdflatex"

# --- Main Script ---
echo "Starting recursive LaTeX compilation using $LATEX_COMMAND..."
echo "---------------------------------------------------------"

# Find all files ending in .tex, execute a command for each one.
# -type f: ensures we only find files, not directories.
# -name "*.tex": specifies the file pattern.
# -exec: executes the following command.
# {} is a placeholder for the current .tex file found.
# \; marks the end of the -exec command.
find . -type f -name "*.tex" -print0 | while IFS= read -r -d $'\0' tex_file; do
    # Get the directory of the .tex file
    dir=$(dirname "$tex_file")

    # Get the filename without the path
    base_name=$(basename "$tex_file")

    echo "Compiling: $tex_file"

    # Compile the file from its own directory to ensure relative paths work
    # We use 'cd' to change to the directory first.
    # The '&&' ensures the $LATEX_COMMAND only runs if 'cd' is successful.
    # The '2>/dev/null' suppresses a lot of the standard pdflatex output
    # to keep the script's output cleaner.
    (cd "$dir" && "$LATEX_COMMAND" "$base_name" 2>/dev/null)

    # Optional: Clean up auxiliary files (like .aux, .log, .toc, etc.)
    # Uncomment the line below if you want to automatically clean up after compilation.
    # find "$dir" -type f \( -name "*.aux" -o -name "*.log" -o -name "*.toc" -o -name "*.out" \) -delete

    echo "Done with: $base_name"
    echo "---"

done

echo "---------------------------------------------------------"
echo "Compilation complete."
