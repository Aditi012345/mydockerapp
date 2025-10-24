# Use OpenJDK base image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy application files
COPY App.java /app

# Compile Java application
RUN javac App.java

# Run the application
CMD ["java", "App"]