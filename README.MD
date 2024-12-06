# Purpose: use RNAseq to determine the effect thiamine on Candida albicans. 
## Study Design

Candida albicans are a commensal yeast that can cause a variety of pathologies. 
WTA1_1.fq.gz, WTA1_2.fq.gz (first analysis done on these files) 
WTB1_1.fq.gz, WTB1_2.fq.gz WTC1_1.fq.gz, WTC1_2.fq.gz WTA2_1.fq.gz, WTA2_2.fq.gz WTB2_1.fq.gz, WTB2_2.fq.gz WTC2_1.fq.gz, WTC2_2.fq.gz

A/B/C = biological replicates (isolates) A1/B1/C1 = Thi+; A2/B2/C2=Thi- _1 & _2 are read pairs

## Analysis Notes

The refseq genomes are:
GCF_000182965.3_ASM18296v3_genomic.fna.gz
GCF_000182965.3_ASM18296v3_genomic.gtf.gz

### FASTQC & TRIMMOMATIC
To begin with, we ran our files through FASTQC & quality controlled them with TRIMMOMATIC (See SBATCH script here: https://github.com/Meghanrb/Class_project/blob/main/trimmomatic_WTA1.SBATCH). 

My reads are WTA1_1 & WTA1_2.

Number of bases per read & quality of reads before & after trimming can be found here: https://docs.google.com/spreadsheets/d/1AOa-XaTzR_PKMIRQDmu8oDTmawXXnkIwEjKOQkNC7Vs/edit?gid=0#gid=0 . For both reads, minor adaption contamination went away after cleaning.

### BOWTIE2

Used C. albicans SC5314 genome assembly (GCF_000182965.3) for alignment. To create index go to interactive node (srun --pty bash) and then: bowtie2-build GCF_000182965.3.fna calb_indx


We have  aligned our sequences using Bowtie2. See this slurm script for details: https://github.com/Meghanrb/Class_project/blob/main/bowtie2.SBATCH

# of cleaned reads after trimmomatic: 20,171,629. # read pairs detected by bowtie2 (found in z01 file): 20,171,629. % aligned concordantly 1 time: 88.31%
% aligned >1 time: 6.87% Overall alignment rate: 98.07%

### HTSeq

Next, we prepared for HTSeq by sorting & indexing our .bam files (samtools sort WTA1.bam -o WTA1.srt.bam to sort and samtools index WTA1.srt.bam to 
index).
