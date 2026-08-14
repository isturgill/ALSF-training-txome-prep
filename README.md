# Salmon transcriptome index preparation

This repository is intended to document how Salmon transcriptome indices are generated for RNA-seq and scRNA-seq training modules.
Currently, this corresponds to our 2019 Houston workshop.

We run all scripts in the Docker container for training (introduced here: [AlexsLemonade/RNA-Seq-Exercises](https://github.com/AlexsLemonade/RNA-Seq-Exercises/pull/22)).
_Note: `optparse` is not installed on that Docker image but is required to generate the tx2gene files._

Scripts are intended to be run sequentially. Use:
* 02a-get_tx2gene_bulk_rnaseq.sh for bulk RNA-seq analyses that use `tximport`
* 02b-get_tx2gene_scrnaseq.sh for scRNA-seq analyses that use salmon alevin

<details>
<summary>ℹ️ Note:</summary>
For scRNA-seq, which uses salmon alevin, we need to use the longer version of the available GTF files (e.g., Mus_musculus.GRCm38.95.chr_patch_hapl_scaff.gtf rather than Mus_musculus.GRCm38.95.gtf). For bulk RNA-seq, `tximport()` handles any discrepancies between FASTA and GTF - for example, filtering rows that aren't in both files. Salmon alevin, however, requires exact matching. For that reason, we also need to ensure that our tx2gene has transcript versions appended. The ensembldb approach in [scripts/get_tx2gene_bulk_rnaseq.R](scripts/get_tx2gene_bulk_rnaseq.R) is suitable for bulk RNA-seq, but we can instead use [scripts/get_tx2gene_scrnaseq.R](scripts/get_tx2gene_scrnaseq.R) to generate the scRNA-seq tx2gene tsv file.

</details>
