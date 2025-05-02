#!/bin/bash
#SBATCH --job-name=smt_options
#SBATCH --output=output.log
#SBATCH --error=output.err
#SBATCH --ntasks=4
#SBATCH --tmp=10000
#SBATCH --time=4-01:00:00
#SBATCH --mem-per-cpu=8G 

python3 main.py