# Load required libraries
library(biomaRt)
library(tidyverse)

# Set up BioMart connection
mart <- useMart("ensembl", dataset = "hsapiens_gene_ensembl")

# Function to retrieve Gene Symbols and replace Entrez IDs
replace_entrez_with_symbols <- function(file_path) {
  
  # Read the input file
  data <- read.table(file_path, header = TRUE, sep = "\t", stringsAsFactors = FALSE)
  
  # Extract unique Entrez IDs from the last column (assuming "core_enrichment")
  entrez_ids <- unique(unlist(strsplit(data$core_enrichment, "/")))
  entrez_ids <- entrez_ids[entrez_ids != ""]  # Remove empty IDs
  
  # Query BioMart for Gene Symbols
  mapping <- getBM(attributes = c("entrezgene_id", "hgnc_symbol"),
                   filters = "entrezgene_id",
                   values = entrez_ids,
                   mart = mart)
  
  # Create a mapping dictionary
  entrez_to_symbol <- setNames(mapping$hgnc_symbol, mapping$entrezgene_id)
  
  # Replace Entrez IDs with Gene Symbols in the "core_enrichment" column
  data$core_enrichment <- sapply(data$core_enrichment, function(x) {
    ids <- unlist(strsplit(x, "/"))
    symbols <- entrez_to_symbol[ids]
    symbols[is.na(symbols)] <- ids[is.na(symbols)]  # Retain original if no match
    paste(symbols, collapse = "/")
  })
  
  # Write updated file to CSV
  output_file <- paste0("Updated_", basename(file_path))
  write.csv(data, output_file, row.names = FALSE)
  cat("Updated file saved as:", output_file, "\n")
}

# List of files to process
file_paths <- c("hcc_GO.txt", "hcc_kegg.txt", "hcc_reactome.txt")

# Apply the function to each file
lapply(file_paths, replace_entrez_with_symbols)
