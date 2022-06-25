#!/bin/bash

# Crea fichero machines con 1 slot por contenedor 
kubectl describe pods -n default | grep IP: | awk -F: '{print $2}' | uniq |awk -F" " '{print $1, "slots=1" }' >machines

# Nombre del primer POD
pod=$(kubectl get pods -n default | awk 'NR==2{print $1}') 

# Copia fichero machines en directorio /root del primer pod
kubectl cp machines default/${pod}:/root

# Ejecuta mpirun dentro del primer pod
kubectl exec ${pod} -- mpirun -v -np 4 -hostfile /root/machines  --allow-run-as-root /root/mpi_cpi 

