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
The command below will add the repository key
```
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
```
The command below will create the repository file
```
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
```
so when we run this update command it will check the repo 
```
sudo apt-get update
```
apt install will download and install jenkins from the repostory
```
sudo apt-get install jenkins
```
Let's check the service
```
systemctl status jenkins
```
All the data in jenkins is stored her /var/lib/jenkins. 
This is the home directory of jenkins. Initial login password is in that location. You should also have a user called jenkins. Jenkins service runs with this user 
```
id jenkins
```
Now let's get the ip and type below in the browser
<public-ip>:8080

You are not going to see maven as a build tool cos it comes as a default build tool in jenkins. Jenkins run on linux, we can install this plugin but it wont work, it will work when we use a Windows slave in Jenkins.

#### Jobs in Jenkins

Two types of Jobs in Jenkins

- Freestyle 
- Pipeline As A Code 

Jobs basically mean wokload which jenkins run for you. Like in bash scrips we write scripts to accomplish a task. In jenkins we create jobs. 
Freestyle jobs are all graphical jobs. Freestyle jobs are just for leaning and understanding purposes. 

#### Installing Tools in Jenkins
In order to install tools on jenkins, Click on manage jenkins, tools. This is an adminstration page so as an admin user you have access 
JDK tools are installed in /usr/lib/jvm/java-1.11.0-openjdk-amd64

We can add jdk 8, since we dont have it we can install it as
```
apt update
```
```
apt install openjdk-8-jdk -y
```
#### First Jenkins Job 

- Click on "create job"
- Give it a name, we will start with free style job 

Go to manage jenkins -> tools
In the the General description section of the job:
Give it a short description: "Running some commands to test Jenkins jobs"
and under jdk  
- put the name OracleJDK11 , 
- for JAVA_HOME : 
ssh into your server and jdk tools are installed in /usr/lib/jvm/. run the command `ls -l /usr/lib/jvm/` You will see the jdk files here. 

Source Code Management:
- None
- Git

Here you mention the url of the source code 

Build Triggers: how to run these jobs. There are different ways 

Build Environment:

Build Steps: This is where the main thing happens. There is a drop down at build step. The list in the drop down depends on the plugins available. IN our first job, we will run simple commands so we click on execute shell. A box comes and lets run the ff commands
id: this shows what user you are
pwd: this shows where this job is running from
whoami

Add  build step: Multiple build step you can add in the same job. Now save it and run the job
A green check means the job was successful. click on it and check the console output

Workspace holds the data of the job. Let's go to configure and add some few build steps like below 
```
echo "This is a test job ..." >> myfile.txt
ls -l
echo
echo "##############################"
echo "Printing my files"
echo "##############################"
cat myfile.txt
```

#### First Build Job
We will now create an actual build job that will fetch our source code from github and build the artifact by using mvn command

Click on new item, give it a name "Build"
Add a title " build artifact from profile sorce code. We need git , maven and jdk and we have all that.
On the JDK drop down, select OracleJDK11
Under SCM, select Git and add the git url which you want to run "


For now we will keep the artifact here  until we see nexus where we will now store all our artifacts.

Let's add a new configuration in Post-build Actions
**/*.war   -the star star slash means recursively look in each and every folder a file that ends in .war and archive it


#### Pipeline As A Code 

Jenkins way of setting up pipeline automatically is by using a Jenkinsfile. We can put the file in a source code or we can add it in the job itself.
Jenkinsfile defines stages in CI/CD piepline
Jenkinsfile is a text file with Pipeline DSL syntax
Similar to groovy, but you dont need to know groovy to write jenkensfile.
Two syntax
 - scripted
 - declarative : we will use declarative

##### Concept
- Pipeline: We start with the main block which is pipeline. This will be executed by Jenkins
- Node/Agent: You can define where this pipeline can get executed on which node or agent
- Stages: Where the execution happens. 
- Steps: In stages you have steps which could be commands like maven install, git pull or upload artifact to Nexus or any step.
 
##### Syntax
```
pipeline {
    agent any (1)
    stages {
        stage('Build') { (2)
            steps {
                //  (3)
            }
        }
        stage('Test') {  (4)
            steps {
                //  (5)
            }
        }
        stage('Deploy') {   (6)
            steps {
                //    (7)
            }
        }
    }
}
```
1. Execute this Pipeline or any of its stages, on any available agent.
2. Defines the "Build" stage.
3. Perform some steps related to the "Build" stage.
4. Defines the "Test" stage.
5. Perform some steps related to the "Test" stage.
6. Defines the "Deploy" stage.
7. Perform some steps related to the "Deploy" stage.

Let's work on a concrete example below:
```
pipeline {
    agent any
    tools {
       maven "MAVEN3"
       jdk "ORACLEJDK11"
      
    }
    stages {              # within stage we have steps
      stage('Fetch Code') {
         steps {
            git branch: 'CICD', url: 'https://github.com/techlearn-center/DevOps.git'   #mention the commands or plugins to use
         }
      }
      stage('Build') {
        steps{     #run shell commands in the steps 
          sh 'mvn install -DskipTests'
        }
        post {
           success {   #if job is successful
              echo 'Archiving artifacgts now.'
              archiveArtifacts artifacts: '**/*.war'
           }
        } 
      }
      stage('UNIT TESTS') {
         steps {
            sh 'mvn test
         }
      }
    }

}
```

Now let's go to jenkins and run this, click new item, name, select pipeline, paste your script and run
Let's replicate the freestyle project we did : fetch, build and run 

Go to manage jenkins -> tools and under jdk  - put the name OracleJDK11 , for JAVA_HOME : 
ssh into your server and ...jdk tools are installed in /usr/lib/jvm/

You can add jdk8 by installing 
apt search jdk
apt install openjdk-8-jdk -y

Maven is easier to install.
Give the name MAVEN3
select the latest version

GIT is by default installed in ubuntu
