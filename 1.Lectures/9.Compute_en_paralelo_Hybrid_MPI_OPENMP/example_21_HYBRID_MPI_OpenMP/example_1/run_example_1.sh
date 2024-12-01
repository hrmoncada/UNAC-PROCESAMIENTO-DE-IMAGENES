#!/bin/bash

## Load the modules
### Load OpenMPI
## module load openmpi 

## Show folder
ls -al
echo " " 
## The options are similar to running an MPI job, with some differences:
rm out

## Show folder
ls -al
echo " " 

## Compile :
echo "Compile  C "
echo " " 

mpicc -fopenmp -o out  example_1_Hello_World_Hybrid.c

#echo "Compile  Fortran "
#echo " " 
#mpif90 -fopenmp -o out example_1_Hello_World_Hybrid.f90 

## Show folder
ls -al

## --np = 4,  specifies the number of MPI processes (“tasks”).
## OMP_NUM_THREADS = 8,  allocates 8 CPUs for each task.

## Set Envirorment: Set number of OpenMP threads per MPI task 
export OMP_NUM_THREADS = 2

## Execute:
echo "Execute "
echo " " 
mpirun -np 4 ./out
