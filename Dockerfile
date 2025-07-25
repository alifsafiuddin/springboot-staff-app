# Use OpenJDK 17 as base image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy the built JAR file instead of WAR
COPY target/testmysql-0.0.1-SNAPSHOT.jar app.jar

# Expose app port
EXPOSE 8080

# Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]
