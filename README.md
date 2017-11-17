## sebastian_smrtlink_hgap_assembly
The 8 SMRTcells are generated in PacBio RSII platform. The data can be assembled using smrtanalysis-v2.3p5. However, smrtanalysis HGAP3 is slowish and spawned job might run in to error. 

The RSII SMRTcell data have been converted to Sequel BAM format and that can be assembled using HGAP4 in SMRTlink v5 . The list of subreads.bam files are collected by the pipeline in a file - lib/inputfiles.fofn.

## Requirements

1) ruby rake
2) smrtlink v5

## Usage

### Run HGAP assembly only
1) rake -f rake_smrtlink_v5.rb projectdir=Assembly run_hgap
By default, the projectdir is HGAP_Assembly
### Run consensus sequences only
2) rake -f rake_smrtlink_v5.rb projectdir=CCSREADS run_ccs       

By default, the projectdir is CCS

### Run both HGAP assembly and CCS
3) rake -f rake_smrtlink_v5.rb


In HPC, the command can be submitted as:

source smrtlink-5.0.1

sbatch --mem 20G -o /dev/null -J hgapsmrtlink --wrap "rake -f rake_smrtlink_v5.rb projectdir=Assembly run_hgap"

