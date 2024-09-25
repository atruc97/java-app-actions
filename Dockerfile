FROM openjdk:11 AS BUILD_IMAGE
RUN apt update && apt install maven -y
COPY ./ java-app-project
RUN cd java-app-project &&  mvn install 

FROM tomcat:9-jre11
LABEL "Project"="Java-app"
LABEL "Author"="TrucDTA"
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=BUILD_IMAGE java-app-project/target/java-app-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
