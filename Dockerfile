FROM debian:stable

RUN apt update && apt -y full-upgrade

RUN apt install -y net-tools less mc vim

RUN apt install -y postgresql
COPY files/postgresql.conf files/pg_hba.conf /etc/postgresql/13/main/
RUN chown postgres: /etc/postgresql/13/main/*
RUN service postgresql start && su postgres -c "psql -c \"ALTER USER postgres PASSWORD 'pp'\""

EXPOSE 5432

WORKDIR /root
COPY files/init.sh .
ENTRYPOINT ["bash", "/root/init.sh"]
# ENTRYPOINT ["bash"]

