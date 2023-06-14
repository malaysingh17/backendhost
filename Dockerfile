FROM adoptopenjdk:17-jdk-hotspot AS build

RUN apt-get update && apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

WORKDIR /build

COPY . .

RUN ./mvnw clean install

FROM adoptopenjdk:17-jdk-hotspot

EXPOSE 8080

WORKDIR /app

COPY --from=build /build/target/demo-1.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
