FROM debian:11.3

WORKDIR /root

RUN apt update && apt -y full-upgrade

RUN apt install -y procps net-tools less mc vim

RUN apt install -y postgresql
COPY files/postgresql.conf files/pg_hba.conf /etc/postgresql/13/main/
RUN chown postgres: /etc/postgresql/13/main/*
RUN service postgresql start && su postgres -c "psql -c \"ALTER USER postgres PASSWORD 'pp'\""

RUN apt install -y ruby-full build-essential libpq-dev
ADD https://www.redmine.org/releases/redmine-5.0.0.tar.gz /opt/
COPY files/setup-redmine.sh files/database.yml files/redmine.sql files/redmine.sh ./
RUN bash setup-redmine.sh

EXPOSE 5432
EXPOSE 3000

COPY files/init.sh .
ENTRYPOINT ["bash", "/root/init.sh"]
# ENTRYPOINT ["bash"]