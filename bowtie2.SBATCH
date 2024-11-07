#!/bin/bash
#SBATCH --job-name=WTA1.SBATCH --output=z01.%x
#SBATCH --mail-type=END,FAIL --mail-user=mrb339@georgetown.edu
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=1 --time=72:00:00
#SBATCH --mem=4G

#Load the Bowtie Module
module load bowtie2


# Paired-end example
bowtie2 -x calb_idx -1 /home/mrb339/class/project/output/WTA1_1.trPE.fq -2 /home/mrb339/class/project/output/WTA1_2.trPE.fq -S WTA1.sam 
