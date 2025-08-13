# Use OpenJDK 21, as required by QuickBuild 14.0+
FROM eclipse-temurin:21-jdk-jammy

# Define the installation directory
ENV QB_HOME /opt/quickbuild
WORKDIR $QB_HOME

# Copy the distribution file from the build context
COPY quickbuild.tar.gz .

# Extract QuickBuild and move contents to the QB_HOME directory
RUN set -ex && \
    tar -xzf quickbuild.tar.gz && \
    DIST_DIR=$(ls -d quickbuild-*/) && \
    mv $DIST_DIR* . && \
    rmdir $DIST_DIR && \
    rm quickbuild.tar.gz

# Configure memory settings (1GB recommended for the server)
RUN sed -i 's/wrapper.java.maxmemory=.*/wrapper.java.maxmemory=1024/' conf/wrapper.conf

# Add and prepare the entrypoint script
COPY server/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose the default QuickBuild web interface port
EXPOSE 8810

# Define volumes for persistence
VOLUME ["$QB_HOME/conf", "$QB_HOME/logs", "$QB_HOME/storage", "$QB_HOME/plugins/site"]

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Default command to run the server in console mode
CMD ["bin/server.sh", "console"]
