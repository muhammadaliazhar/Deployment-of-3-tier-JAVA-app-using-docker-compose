# stage 1 - build the  JAR file using maven
FROM maven:3.8.3-openjdk-17 AS builder

WORKDIR /app

COPY . .

# create JAR file
RUN mvn clean install -DskipTests=true

# stage 2 - execute JAR file from the above stage
FROM openjdk:17-alpine

WORKDIR  /app

COPY --from=builder /app/target/*.jar  /app/expensesapp.jar

CMD ["java" , "-jar" , "expensesapp.jar"]
