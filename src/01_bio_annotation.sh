#!/bin/bash

### TITLE : Get annotation for biological entities (gene, drugs, etc) which will be used for further data processing
### AUTHOR : Perales-Paton, Javier - jperales@cnio.es
### LICENSE : GPL-v3
### DESCRIPTION : 


## 1 Create the directory for Annotations
if [ ! -e ./data/Annotation ];then
	echo -e "[INFO] Creating './data/Annotation' directory.";
	mkdir ./data/Annotation;
else echo -e "[WARN] './data/Annotation' already exists.";
fi

## 2 Gene Symbol and Names (hgnc), with CDS length and GC content from biomart (ensEMBL)
echo -e "[INFO] Creating Gene Annotation (gene id maps, exon length, GC content, etc) for GRCh37. Be patient, it will take long time...";
Rscript ./src/__ANN_GRCh37.R &> ./log/__ANN_GRCh37.log;
Rscript ./src/__ANN_hgnc_2012_to_2014.R &> ./log/__ANN_hgnc_2012_to_2014.log;

## 3 Build a Genomic Ranges object for the human genes along the genome
echo -e "[INFO] Building a GenomicRanges object with genomic coordinates for the genes along the genome.";
Rscript ./src/__ANN_prepareGenomicRegions.R &> ./log/./src/__ANN_prepareGenomicRegions.log;
