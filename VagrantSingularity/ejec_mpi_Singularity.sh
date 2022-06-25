#!/bin/bash
awk 'NR>=6&&NR<=7' install.sh | awk -F" " '{print $1, "slots=1"}' > machines

mpirun -np 2 --hostfile machines singularity exec contenedorSingularity.sif /opt/mpi_cpi
