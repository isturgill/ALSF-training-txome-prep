# I. Sturgill as an online supplement for original CCDL 2019 (J. Taroni)
# Purpose: generating a tx2gene TSV file for use with salmon alevin 
# for scRNA-seq analysis from an Ensembl GTF file
#
# USAGE: Rscript scripts/get_tx2gene_scrnaseq.R \
#         --gtf_file <PATH_TO_ENSEMBL_GTF_FILE> \
#         --output_file <PATH_TO_OUTPUT_TSV_FILE>
#

#### install optparse if necessary ---------------------------------------------

if (!("optparse" %in% installed.packages())) {
    install.packages("optparse", suppressUpdates = TRUE)
}

#### option parsing ------------------------------------------------------------

option_list <- list(
  optparse::make_option("--gtf_file", type = "character"),
  optparse::make_option("--output_file", type = "character")
)

opt_parser <- optparse::OptionParser(option_list = option_list)
opt <- optparse::parse_args(opt_parser)
gtf_file <- opt$gtf_file
output_file <- opt$output_file

#### main ----------------------------------------------------------------------
# For scRNA-seq with salmon alevin, we need to reconcile a versioned reference
# fasta and an unversioned tx2gene when created with ensembldb (as we did for bulk)
# So instead, we'll concatenate the GTF transcript_id and transcript_version
# to create the expected versioned tx2gene tsv

gtf <- rtracklayer::readGFF(gtf_file)

tx2gene <- gtf |>
	dplyr::filter(!is.na(transcript_id) | !is.na(transcript_version)) |>
	dplyr::mutate(tx_name = stringr::str_c(transcript_id, ".", transcript_version)) |>
	dplyr::select(tx_name, gene_id) |>
	dplyr::distinct()

readr::write_tsv(tx2gene, file = output_file)
