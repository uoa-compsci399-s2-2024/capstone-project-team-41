FROM gradle:jdk17 AS build
COPY --chown=gradle:gradle .. /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon

FROM amazoncorretto:17-alpine-jdk

EXPOSE 9191

RUN mkdir /app

COPY --from=build /home/gradle/src/grpc-server/build/libs/*.jar /app/spring-boot-application.jar

ENTRYPOINT ["java", "-jar","/app/spring-boot-application.jar"]