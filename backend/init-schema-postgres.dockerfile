FROM postgres

COPY schema/*.sql /docker-entrypoint-initdb.d/
COPY data/*sql /docker-entrypoint-initdb.d/

ENV POSTGRES_USER mis_g1
ENV POSTGRES_PASSWORD mis
ENV POSTGRES_DB os_db

EXPOSE 5432