#!/bin/bash -e

# Crea fichero machines con 1 slot por contenedor 
#docker network inspect mpi_default | grep IPv4Address | awk '{print $2}' | uniq | tr -d '"' | tr -d ',' | awk -F/ '{print $1}'|  awk -F" " '{print $1, "slots=1" }' >machines1

#Borro la última línea, porque no pertenece a la de los contenedores
#head -n -1 machines1 >machines

#rm machines1

#Obtención de los identificadores de todos los contenedores
if [ -f machines ]  #como se sobrescribe el fichero machines para que vaya guardando todas las ips, hay que borrarlo si existe
then
rm machines
fi
docker service ps mpi_mpi-cpi | grep Running | awk '{print $1}' > IdContenedores
while read line # bucle para que vaya leyendo cada linea donde contenemos a las id de los contenedores
do 							#igual tenemos que poner la subred (porque si es 192.*, no funciona)
docker inspect "$line" | grep $(docker network inspect mpi_default | grep Subnet | awk '{print $2}' | uniq | tr -d '"' | tr -d ',' | awk -F. '{print $1 ".*"}') | tr -d '"' | awk -F/ '{print $1}' | sed -r 's/\s+//g' > IpContenedor1 #el sed es para eliminar espacios y el inspect está abajo
tail -1 IpContenedor1 > IpContenedor #nos quedamos con la última línea que es la que nos intersa
cat IpContenedor | awk -F" " '{print $a, "slots=1" }' >> machines  #mostramos el fichero machines como queremos 
done < IdContenedores

rm IpContenedor1  #borramos archivos por gusto
rm IpContenedor


# Nombre de la primera máquina
maquina=$(docker ps | awk 'NR==2{print $12}') 
# Obtención de la subnet
subnet=$(docker network inspect mpi_default | grep Subnet | awk '{print $2}' | uniq | tr -d '"' | tr -d ',')

# Copia fichero machines en directorio /root de la primera máquina
docker cp /vagrant/machines ${maquina}:/root/

# Ejecuta mpirun dentro de la primera máquina
docker exec ${maquina} mpirun -np 4 -hostfile /root/machines --allow-run-as-root --mca oob_tcp_if_include ${subnet} /root/mpi_cpi

#docker network inspect mpi_default --> Subred
#docker service ps mpi_mpi-cpi --> Para obtener los ids de cada contenedor
#docker inspect 33gq54yfimsv --> Para obtener las ips de cada contenedor


#vs88ve0hre60
#1jag2l9t3c4p
#zkorxqkj63o6
#1vrnyjrutr8b