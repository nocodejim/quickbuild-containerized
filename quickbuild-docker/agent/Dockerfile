# Use OpenJDK 21
FROM eclipse-temurin:21-jdk-jammy

# Define the installation directory
ENV QB_AGENT_HOME /opt/quickbuild-agent
WORKDIR $QB_AGENT_HOME

# Copy the distribution file from the build context
COPY quickbuild.tar.gz /tmp/quickbuild.tar.gz

# Efficiently install the agent from the main distribution
RUN set -ex && \
    tar -xzf /tmp/quickbuild.tar.gz --wildcards '*/lib/agent.tar.gz' -C /tmp && \
    AGENT_PKG=$(find /tmp -name agent.tar.gz) && \
    tar -xzf $AGENT_PKG -C $QB_AGENT_HOME && \
    rm -rf /tmp/quickbuild.tar.gz /tmp/quickbuild-*

# Configure memory settings (256MB recommended for agents)
RUN sed -i 's/wrapper.java.maxmemory=.*/wrapper.java.maxmemory=256/' conf/wrapper.conf

# Add and prepare the entrypoint script
COPY agent/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

VOLUME ["$QB_AGENT_HOME/logs"]

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Default command to run the agent in console mode
CMD ["bin/agent.sh", "console"]
