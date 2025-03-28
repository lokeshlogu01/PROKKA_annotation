#!/bin/bash

# Directory containing genome FASTA files
INPUT_DIR="./genomes"
OUTPUT_DIR="./prokka_annotations"

# Ensure Prokka is installed
if ! command -v prokka &> /dev/null
then
    echo "Error: Prokka is not installed. Install it with 'conda install -c bioconda prokka'"
    exit 1
fi

# Create output directory if not exists
mkdir -p "$OUTPUT_DIR"

# Loop through all .fasta and .fa files in the directory
for file in "$INPUT_DIR"/*.fasta "$INPUT_DIR"/*.fa; do
    # Check if any matching files exist
    [ -e "$file" ] || continue
    
    # Extract filename without extension
    BASENAME=$(basename "$file" | sed 's/\..*$//')
    
    # Run Prokka with all parameters
    echo "Running Prokka on $file..."
    prokka --outdir "$OUTPUT_DIR/$BASENAME" --prefix "$BASENAME" --kingdom Virus  "$file"
    echo "Annotation for $BASENAME completed."

done

echo "All genome annotations are complete. Results are in $OUTPUT_DIR"
