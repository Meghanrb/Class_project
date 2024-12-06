#!/bin/bash
#SBATCH --job-name=htseq2.SBATCH --output=z01.%x
#SBATCH --mail-type=END,FAIL --mail-user=mrb339@georgetown.edu
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=1 --time=24:00:00
#SBATCH --mem=4G

source activate htseq

# Define input files and output
BAM_FILE="/home/mrb339/class/project/output/samtools/HTSeq/WTA1.srt.bam"
GTF_FILE="/home/mrb339/class/project/output/samtools/HTSeq/GCF_000182965.3_ASM18296v3_genomic.gtf"
OUTPUT_FILE="WTA1_htseqCount.txt"

# Run HTSeq-count
htseq-count -f bam -r pos -s no -t exon -i gene_id $BAM_FILE $GTF_FILE > $OUTPUT_FILE
