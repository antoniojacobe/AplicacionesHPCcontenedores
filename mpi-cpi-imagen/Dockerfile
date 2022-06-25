FROM ubuntu:20.04
EXPOSE 22
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
RUN apt-get update
RUN apt-get install -y net-tools
RUN apt-get install -y openssh-server
RUN apt-get install -y openmpi-bin

COPY mpi_cpi.c /root/mpi_cpi.c
RUN mpicc -o /root/mpi_cpi /root/mpi_cpi.c
RUN mkdir /root/.ssh
COPY config /root/.ssh/config
RUN chmod 664 /root/.ssh/config

# Modify `sshd_config`
RUN sed -ri 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^#PermitEmptyPasswords no/PermitEmptyPasswords yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^UsePAM yes/UsePAM no/' /etc/ssh/sshd_config

# Delete root password (set as empty)
RUN passwd -d root

ENTRYPOINT ["sh", "/docker-entrypoint.sh"]

