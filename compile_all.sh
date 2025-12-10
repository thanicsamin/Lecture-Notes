LATEX_COMMAND="pdflatex"

echo "Starting recursive LaTeX compilation using $LATEX_COMMAND..."
echo "---------------------------------------------------------"

find . -type f -name "*.tex" -print0 | while IFS= read -r -d $'\0' tex_file; do
    dir=$(dirname "$tex_file")

    base_name=$(basename "$tex_file")

    echo "Compiling: $tex_file"

    (cd "$dir" && "$LATEX_COMMAND" "$base_name" 2>/dev/null)

    echo "Done with: $base_name"
    echo "---"
done

echo "---------------------------------------------------------"
echo "Compilation complete."
