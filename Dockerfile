# Stage 1: Build
FROM maven:3.8.1-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM openjdk:17-slim
WORKDIR /app
COPY --from=build /app/target/*.jar ./my-spring-app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "my-spring-app.jar"]
