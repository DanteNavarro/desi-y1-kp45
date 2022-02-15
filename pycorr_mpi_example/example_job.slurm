#!/bin/bash
#SBATCH --nodes 3
#SBATCH -C haswell
#SBATCH -q debug
#SBATCH -J CF_test
#SBATCH -t 00:29:00





export SLURM_CPU_BIND=none # important when using "mpirun" from Intel-MPI!
# Do NOT use this with srun!

module rm darshan
module add hdf5-parallel # For serial HDF5 code.
#module load cray-hdf5-parallel ###For parallel HDF5 code. It works for srun.
export HDF5_USE_FILE_LOCKING=FALSE

conda activate analysis
# This is where you install the required packages: numpy, pycorr, cosmoprimo, mpi4py, h5py(for HDF), astropy (for FITS)

mpirun -map-by ppr:4:socket -np 3 python pycorr_MPI.py example_conf
#srun -n 3 python pycorr_MPI.py example_conf ##with srun

