# Prerequisites
#
- JDK 11 
- Maven 3 
- MySQL 8

# Technologies 
- Spring MVC
- Spring Security
- Spring Data JPA
- Maven
- JSP
- Tomcat
- MySQL
- Memcached
- Rabbitmq
- ElasticSearch
# Database
Here,we used Mysql DB 
sql dump file:
- /src/main/resources/db_backup.sql
- db_backup.sql file is a mysql dump file.we have to import this dump to mysql db server
- > mysql -u <user_name> -p accounts < db_backup.sql

# Continuous Integration
In the development of a product, developers regularly commit, build, and locally test their code before pushing it to a centralized version control system. This practice is consistently followed by all team members.

The issue arises from the frequent and individual code merges performed by various developers into the centralized repository, often several times a day. As days turn into weeks, and sometimes even months, the code continues to be merged without a comprehensive build or test on an integrated platform. This delayed integration can lead to the emergence of numerous bugs, issues, and conflicts when the code is eventually compiled and tested as a whole.

This problem stems from the fact that although code is being merged, it's not being sufficiently integrated in a timely manner, leading to a significant amount of rework for developers to address these emerging issues. Consequently, integration becomes a cumbersome and painful process.

