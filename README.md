# 092020 Appathon interent-and-applications
## Requirements
- Java 14
- MySQL 5.1 (jdbc)
- Tomcat 9.0
- Eclipse EE 2020

## Setup

change the database credentials in the create_database.java file and compile it
run the script with: java -cp .;mysql-connector-java-5.1.18-bin.jar Create_database

copy the project (file called 092020 Apathon...) into your eclipse workspace and resolve eclipse dependencies
change database credentials in the files:
- cart.jsp
- login.jsp
- myhomepage.jsp
- newUser.jsp
- products.jsp
- pageUpdateServlet.java
- purchase.java

run the app on a tomcat server
go to http://localhost:8080/092020_Apathon_-_internet_and_applications/
