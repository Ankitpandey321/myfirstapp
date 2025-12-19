FROM eclipse-temurin:21-jre

WORKDIR /app

COPY target/myfirstapp-1.0.0.jar app.jar

CMD ["java", "-jar", "app.jar"]
