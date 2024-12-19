Converting Entrez IDs into Gene Symbols

This repository contains an R script and a Docker setup for converting Entrez IDs into Gene Symbols using the BioMart service. The solution is tailored for bulk processing of files containing pathway enrichment results, such as GO, KEGG, and Reactome results.

Features

Entrez ID to Gene Symbol Conversion: Automatically replaces Entrez IDs with Gene Symbols in a specified column of input files.

Supports Multiple Files: Batch processing for multiple input files.

Docker Integration: Ensures a reproducible and portable environment for running the script.

Prerequisites

For Standalone Usage

R (4.0 or later)

Required R packages:
  
  biomaRt

tidyverse

For Dockerized Usage

Docker installed on your system.

Repository Structure

.
├── Convert_Entrez_id_into_Gene_Symbol.R   # Main R script
├── Dockerfile                             # Docker configuration file
├── hcc_GO.txt                             # Example input file (GO enrichment results)
├── hcc_kegg.txt                           # Example input file (KEGG enrichment results)
├── hcc_reactome.txt                       # Example input file (Reactome enrichment results)

Usage

Standalone R Script

Clone the repository:
  
  git clone https://github.com/carlosbuss1/Converting_EntrezID_into_GeneSymbol.git
cd Converting_EntrezID_into_GeneSymbol

Open R and install the required packages:
  
  install.packages(c("biomaRt", "tidyverse"))

Run the script:
  
  Rscript Convert_Entrez_id_into_Gene_Symbol.R

Ensure the input files (hcc_GO.txt, hcc_kegg.txt, hcc_reactome.txt) are present in the directory.

Dockerized Workflow

Build the Docker image:
  
  docker build -t r-script-docker .

Run the Docker container:
  
  docker run --rm -v $(pwd):/usr/src/app r-script-docker

The updated files will be saved in the same directory with the prefix Updated_.

Input File Format

Tab-delimited text files.

Must include a column named core_enrichment containing Entrez IDs separated by /.

Example:
  
  Term	GeneRatio	core_enrichment
GO:0008150	10/100	1234/5678/91011

Output

Updated files with the prefix Updated_.

Example output:
  
  Term	GeneRatio	core_enrichment
GO:0008150	10/100	GeneA/GeneB/GeneC

Known Issues

Ensure that Entrez IDs in the input files are valid and match those in the BioMart database.

If BioMart service is down, the script may fail to retrieve mappings.

Contribution

Feel free to open an issue or submit a pull request if you encounter any problems or have suggestions for improvement.

License

This project is licensed under the MIT License. See the LICENSE file for details.

Author

Carlos BussBioinformatician at STML LabGitHub Profile
