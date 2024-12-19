# Base image with R
FROM rocker/r-ver:4.3.1

# Install necessary system libraries
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install R packages
RUN R -e "install.packages(c('biomaRt', 'tidyverse'), repos='https://cloud.r-project.org/')"

# Set working directory
WORKDIR /usr/src/app

# Copy the R script and data files to the container
COPY script.R .
COPY hcc_GO.txt .
COPY hcc_kegg.txt .
COPY hcc_reactome.txt .

# Set the command to run the script
CMD ["Rscript", "script.R"]

