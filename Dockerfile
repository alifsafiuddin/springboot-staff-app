# Use OpenJDK 17 as base image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy built JAR file into container
COPY target/testmysql-0.0.1-SNAPSHOT.war app.war

# Expose port (depends on embedded container)
EXPOSE 8080

# Run the app
ENTRYPOINT ["java", "-jar", "app.war"]
