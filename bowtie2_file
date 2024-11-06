#!/bin/bash
#SBATCH --job-name=WTA1.SBATCH --output=z01.%x
#SBATCH --mail-type=END,FAIL --mail-user=mrb339@georgetown.edu
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=1 --time=72:00:00
#SBATCH --mem=4G

#Load the Bowtie Module
module load gcc
module load bowtie2

# Change to temp working directory with example files
cd /home/mrb339/class/project/output

# Indexing a reference genome
bowtie2-build ./home/mrb339/class/project/GCF_000182965.3_ASM18296v3_genomic.fna WTA1


# Paired-end example
bowtie2 -p $SLURM_CPUS_PER_TASK -x WTA1 -1 ./home/mrb339/class/project/output/WTA1_1.trPE.fq -2 ./home/mrb339/class/project/output/WTA1_2.trPE.fq -S WTA1.sam
