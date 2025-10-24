# Use OpenJDK base image FROM openjdk:17-jdk-slim

# Copy application files WORKDIR /app
COPY App.java /app



RUN javac App.java CMD ["java", "App"]
