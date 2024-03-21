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

### Problem:
The issue arises from the frequent and individual code merges performed by various developers into the centralized repository, often several times a day. As days turn into weeks, and sometimes even months, the code continues to be merged without a comprehensive build or test on an integrated platform. This delayed integration can lead to the emergence of numerous bugs, issues, and conflicts when the code is eventually compiled and tested as a whole.

This problem stems from the fact that although code is being merged, it's not being sufficiently integrated in a timely manner, leading to a significant amount of rework for developers to address these emerging issues. Consequently, integration becomes a cumbersome and painful process.

### Solution: 
Whenever there is a code change in a centralized repository or for every commit made by a developer, we automatically build and test the code for each commit. This automation ensures that any time a code change occurs, the code is fetched, built, and tested. If any issues arise, the developer is immediately notified to fix the code.

This process is known as continuous integration. It enables developers to catch and fix problems early in the development cycle, eliminating the delay and accumulation of issues. Thus, not only are codes merged, but every commit is tested and the developer is notified of any failures.

Automating this process is the essence of continuous integration, with Jenkins being one of the most renowned tools for this purpose. Whenever a developer makes a code change, Jenkins fetches, builds, evaluates the code, and sends notifications to the developer if any issues are detected.

Jenkins is celebrated for its open-source nature and extensibility. With contributions from developers worldwide, it is constantly improving. Jenkins boasts a wide array of plugins, enhancing its versatility. It can serve as a continuous integration server, a continuous delivery tool, a script execution platform, a software testing facilitator, a cloud automation tool, or as a means to integrate with other DevOps and developer tools.

### Jenkins Installation
```
sudo apt update
```
```
sudo apt install openjdk-11-jdk -y
```
- The command below will add the repository key
```
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
```
- The command below will create the repository file
```
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
```
