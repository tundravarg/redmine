FROM debian:stable

RUN apt update && apt -y full-upgrade

RUN apt install -y net-tools less mc vim

RUN apt install -y postgresql
RUN awk "/#listen_addresses/ {print \"listen_addresses = '*'\"} {print}" /etc/postgresql/13/main/postgresql.conf > /etc/postgresql/13/main/postgresql.conf.tmp
RUN mv /etc/postgresql/13/main/postgresql.conf.tmp /etc/postgresql/13/main/postgresql.conf
RUN echo "# External addresses" >> /etc/postgresql/13/main/pg_hba.conf
RUN echo "host    all    all    0.0.0.0/0    md5" >> /etc/postgresql/13/main/pg_hba.conf
RUN echo "host    all    all    ::/0         md5" >> /etc/postgresql/13/main/pg_hba.conf
RUN service postgresql start && su postgres -c "psql -c \"ALTER USER postgres PASSWORD 'pp'\""

EXPOSE 5432

WORKDIR /root
COPY files/init.sh .
ENTRYPOINT ["bash", "/root/init.sh"]
# ENTRYPOINT ["bash"]

