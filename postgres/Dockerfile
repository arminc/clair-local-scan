ARG  VERSION=16-alpine

FROM postgres:${VERSION}

# Argument for external data directory
ARG SOURCE_DIR=/mnt/postgres

# Copy data from the specified host folder into the container

RUN mkdir -p /var/lib/postgresql/clair

COPY --from=postgres / /var/lib/postgresql/clair

# Ensure proper permissions
RUN chown -R postgres:postgres /var/lib/postgresql/clair

# Expose PostgreSQL port
EXPOSE 5432

# Start PostgreSQL
CMD ["postgres"]