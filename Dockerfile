# Etapa 1: Construir el JAR con Gradle
FROM gradle:8.10-jdk21 AS builder
WORKDIR /app
COPY build.gradle settings.gradle ./
COPY src ./src
RUN gradle build --no-daemon -x test

# Etapa 2: Crear la imagen final
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=builder /app/build/libs/test-0.0.1-SNAPSHOT.jar test.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "test.jar"]