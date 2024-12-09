# Purpose: use RNAseq to determine the effect thiamine on Candida albicans. 
## Study Design

Candida albicans are a commensal yeast that can cause a variety of pathologies. 
WTA1_1.fq.gz, WTA1_2.fq.gz (first analysis done on these files) 
WTB1_1.fq.gz, WTB1_2.fq.gz WTC1_1.fq.gz, WTC1_2.fq.gz WTA2_1.fq.gz, WTA2_2.fq.gz WTB2_1.fq.gz, WTB2_2.fq.gz WTC2_1.fq.gz, WTC2_2.fq.gz

A/B/C = biological replicates (isolates) 

A1/B1/C1 = Thi+; A2/B2/C2=Thi- 

_1 & _2 are read pairs

## Analysis Notes

The refseq genomes are:

GCF_000182965.3_ASM18296v3_genomic.fna.gz

GCF_000182965.3_ASM18296v3_genomic.gtf.gz

### FASTQC & TRIMMOMATIC 

This step is for quality control.

To begin with, we ran our files through FASTQC & quality controlled them with TRIMMOMATIC. Using ![this SBATCH script.](https://github.com/Meghanrb/Class_project/blob/main/trimmomatic_WTA1.SBATCH)

My reads are WTA1_1 & WTA1_2.

Number of bases per read & quality of reads before & after trimming can be found ![here.](https://docs.google.com/spreadsheets/d/1AOa-XaTzR_PKMIRQDmu8oDTmawXXnkIwEjKOQkNC7Vs/edit?gid=0#gid=0) For both reads, minor adaption contamination went away after cleaning.

### BOWTIE2
This step is to align reads to a reference geneome (see below).

Used C. albicans SC5314 genome assembly (GCF_000182965.3) for our reference genome for alignment. To create index go to interactive node (srun --pty bash) and then: bowtie2-build GCF_000182965.3.fna calb_indx


We have  aligned our sequences using Bowtie2. See ![this slurm script](https://github.com/Meghanrb/Class_project/blob/main/bowtie2.SBATCH) for details.

Details on alignments can be found ![here.](https://docs.google.com/spreadsheets/d/1fa-FXVMlCXOZkbHSx_mMg0OXLMy9BeBJg8uWrEMpKGo/edit?gid=0#gid=0) The # of cleaned reads after trimmomatic: 20,171,629. # read pairs detected by bowtie2 (found in z01 file): 20,171,629. % aligned concordantly 1 time: 88.31%
% aligned >1 time: 6.87% Overall alignment rate: 98.07%

### HTSeq

This step is to count reads per gene model

Next, we prepared for HTSeq by sorting & indexing our .bam files (samtools sort WTA1.bam -o WTA1.srt.bam to sort and samtools index WTA1.srt.bam to 
index). We then created a Conda environment to run HTSeq. The SBATCH script for HTSeq can be found ![here.](https://github.com/Meghanrb/Class_project/blob/main/HTSeq.SBATCH)

We then downloaded the output files to put into R with the DESeq2 program.

### DESeq2

This step is to measure differentially expressed genes. The code for these outputs can be found ![here.](https://github.com/Meghanrb/Class_project/blob/main/DESeq_script_R)

Our PCA plot ![PCA plot](https://github.com/Meghanrb/Class_project/blob/main/TH-vTH%2B_pcaplot.png) shows that two principle components describe 97% of the variance seen between the two treatments, with PC1 explaining 88% of the variance. 

Our Volcano plot ![Volcano plot](https://github.com/Meghanrb/Class_project/blob/main/volcano_TH-vTH%2B.png) shows that there are 13 genes expressed significantly differently in thiamine absent vs. thiamine present conditions. The rest of the analysis will focus on exploring these 13 genes. The gene names and notes on gene function can be found ![here.](https://github.com/Meghanrb/Class_project/blob/main/signif_TH-vTH%2B_%2Bnames%2Bbiofunct.csv) From this analysis, it can be seen that many genes are related to an induced spider biofilm.

### Gene Ontology (GO) Analysis
GO analysis was done using ![Panther classification system](https://pantherdb.org/tools/compareToRefList.jsp) (GO Ontology database DOI: 10.5281/zenodo.12173881 Released 2024-06-17). Using the Panther overrepresentation test, up to 8 out of the 9 genes whose function is known were found to play a role in the thiamine biosynthetic process pathway. The full results for this test can be found ![here.](https://github.com/Meghanrb/Class_project/blob/main/analysis.png) 

## Final Interpretation of results
Using bulk RNA-seq data from thiamine deficient and thiamine present groups, we were able to determine that genes related to biofilm production and thiamine biosynthetic pathways were differentially expressed. 

These results seem to suggest that in the absence of Thiamine, C. albicans upregulates pathways related to Thiamine production. Thiamine has been suggested to play an important role in biofilm synthesis (Ketelboeter et al., 2023) and so therefore genes in both of these mechanisms being altered suggests that it is possible that the ability of C. albicans to form biofilms may be altered in the absence of thiamine, although further work is needed to confirm this. Overall, these results suggest that C. albicans are attempting to overcome environmental deficiencies and are displaying a plasticity to the environmental conditions. 


Ketelboeter LM, Mitra S, Gyaneshwar P, A thiamine transporter is required for biofilm formation by Rhizobium sp. IRBG74, FEMS Microbiology Letters, Volume 370, 2023, fnad046, https://doi.org/10.1093/femsle/fnad046
