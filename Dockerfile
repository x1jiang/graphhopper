# Build stage
FROM maven:3.9.5-eclipse-temurin-21 as build
WORKDIR /graphhopper

# Copy sources
COPY graphhopper/ ./
# Build the project
RUN mvn clean install -DskipTests

# Final image
FROM eclipse-temurin:21.0.1_12-jre
# Increase Java Heap Size
ENV JAVA_OPTS="-Xmx8g -Xms8g"

# Install necessary tools
RUN apt-get update && apt-get install -y curl wget && rm -rf /var/lib/apt/lists/*

# Create data directory
RUN mkdir -p /data

# Set working directory
WORKDIR /graphhopper

# Copy the built JAR file from the build stage
COPY --from=build /graphhopper/web/target/graphhopper*.jar ./

# Copy the script and configuration from the build context
COPY graphhopper.sh ./
COPY graphhopper/config-example.yml ./

# Grant execute permission to graphhopper.sh
RUN chmod +x graphhopper.sh

# Set the application to bind to all network interfaces (0.0.0.0)
RUN sed -i '/^ *bind_host/s/^ */&# /p' config-example.yml

VOLUME ["/data"]
EXPOSE 8989 8990

HEALTHCHECK --interval=5s --timeout=3s CMD curl --fail http://localhost:8989/health || exit 1

# Default command to run when starting the container
ENTRYPOINT ["./graphhopper.sh"]

# Provide default arguments (same as your recommended run command)
CMD ["--url", "https://download.geofabrik.de/north-america/us/texas-latest.osm.pbf", "--host", "0.0.0.0"]