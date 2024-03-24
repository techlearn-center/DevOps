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

### pom.xml
pom.xml is a fundamental file in Maven, a popular build automation tool used primarily for Java projects. POM stands for Project Object Model. The pom.xml file is an XML file that contains information about the project and configuration details used by Maven to build the project. It includes the project's directory structure, plugin information, dependencies, and other necessary configurations. Here are the key components often found in a pom.xml file:
#### Basic Structure
- `\<modelVersion\>`: Specifies the model version of the POM. For Maven 2 and 3, this is usually 4.0.0.
- `\<groupId\>`: Defines the group or organization that the project belongs to. This is often used to structure the package names.
- `\<artifactId\>`: The name of the project. This is used as the base name for the generated artifact (e.g., JAR or WAR file).
- `\<version\>`: The version of the project. Together with the groupId and artifactId, this uniquely identifies the artifact produced by Maven.
- `\<packaging\>`: Defines how the project should be packaged. Common values include jar, war, and pom.

#### Key Elements
- `\<dependencies\>`: Lists the project dependencies required to build and run the project. Each dependency is defined by its groupId, artifactId, and version.
- `\<build\>`: Specifies build settings, including plugins and tasks that need to be executed during the build process.
- `\<properties\>`: Allows the definition of project-wide properties that can be used throughout the POM.
- `\<repositories\>`: Defines additional repositories for downloading dependencies that are not available in Maven Central.
- `\<pluginRepositories\>`: Specifies repositories for downloading plugins.
- `\<distributionManagement\>`: Configures where to publish artifacts and how to release the project.



#### Example
Here's a simple example of a pom.xml file for a Java project:
```
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.example</groupId>
    <artifactId>my-project</artifactId>
    <version>1.0-SNAPSHOT</version>
    <packaging>jar</packaging>

    <dependencies>
        <!-- Example Dependency -->
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>4.12</version>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <!-- Example Plugin -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.8.1</version>
                <configuration>
                    <source>1.8</source>
                    <target>1.8</target>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
```
This example specifies a simple Java project that includes a dependency on JUnit for testing and configures the Maven Compiler Plugin to compile the project using Java 1.8. The `pom.xml` file is central to a Maven project, dictating how the project is built, packaged, and managed.

The `pom.xml` file itself does not explicitly define the project's directory structure in the form of paths or folder listings. Instead, Maven projects follow a standard directory layout convention, which is implicitly understood by Maven and does not need to be specified in the pom.xml. This convention allows Maven to automatically know where to find source code, resources, test code, and other elements of the project. However, if your project deviates from these conventions, you can specify alternative paths using the <build> section in the pom.xml.

#### Standard Maven Project Directory Structure
Here's an overview of the default Maven project directory structure:

- `src/main/java`: This directory contains the project's main Java source files.
- `src/main/resources`: This directory holds resources associated with the project, such as properties files, configuration files, and other non-Java resources that should be included in the final artifact.
- `src/test/java`: Contains the Java source files for the project's tests.
- `src/test/resources`: Resources for the test code, similar to src/main/resources, but not included in the final artifact and only used during testing.
- `target/`: The default directory where Maven outputs the project artifacts and other generated files (e.g., compiled classes, packaged JAR).

#### Specifying a Different Directory Structure
If you need to specify a different source or resource directory, you can do so in the pom.xml under the <build> section. For example, to change the source directory:
```
<build>
    <sourceDirectory>src/main/custom</sourceDirectory>
</build>

```
And to change the resources directory:

```
<build>
    <resources>
        <resource>
            <directory>src/main/custom-resources</directory>
        </resource>
    </resources>
</build>
```
These custom configurations allow Maven to adapt to non-standard project structures, though it's generally recommended to stick with the conventional layout for consistency and compatibility with other Maven tools and projects.

##### JUnit
JUnit is a popular unit testing framework for the Java programming language. It is an open-source tool designed to write and run repeatable tests, providing annotations to identify test methods and assertions to test expected outcomes. JUnit is instrumental in test-driven development (TDD) and is widely used in the development of test cases for small units of code. The framework supports various kinds of tests including unit tests, integration tests, and more, allowing developers to ensure their code behaves as expected before it goes into production.

##### JaCoCo
JaCoCo (Java Code Coverage) is an open-source toolkit for measuring and reporting Java code coverage. Code coverage is a metric used to describe the degree to which the source code of a program is executed when a particular test suite runs. JaCoCo can integrate with build tools like Maven and Gradle, and it supports various coverage counters at the class, method, line, and branch level, enabling developers to understand which parts of their codebase are adequately tested and which require more attention. This information is crucial for improving software quality and reliability.

##### CheckStyle
CheckStyle is a development tool to help programmers write Java code that adheres to a coding standard. It automates the process of checking Java code to spare humans of this boring (but important) task. This makes it ideal for projects that want to enforce a coding standard. CheckStyle is highly configurable and can be made to support almost any coding standard. It can check many aspects of your source code, including looking for code smells, coding style issues, and even detecting class design problems. CheckStyle can be integrated into IDEs (like IntelliJ IDEA or Eclipse), build tools (like Maven or Gradle), and continuous integration pipelines to provide feedback on code quality and adherence to coding standards.

Together, JUnit, JaCoCo, and CheckStyle form a powerful trio for improving code quality, ensuring code correctness, and maintaining a clean, standardized codebase in Java projects. They are often used in continuous integration (CI) pipelines to automate the process of code verification, ensuring that new changes meet quality standards and do not introduce regressions.

To integrate JUnit, JaCoCo, and CheckStyle reports with SonarQube analysis in a Jenkins pipeline, you will need to specify the correct properties in your SonarQube scanner command or in a sonar-project.properties file in your project's root directory. These properties tell SonarQube where to find the reports generated by these tools during the build.

Below is an example of a Jenkins pipeline script, including the additional SonarQube analysis properties for JUnit, JaCoCo, and CheckStyle:
```
pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Checkout your project source code
                checkout scm
            }
        }
        
        stage('Build and Test') {
            steps {
                // Your build command here
                // For example, for a Maven project:
                sh 'mvn clean verify'
            }
        }
        
        stage('SonarQube analysis') {
            steps {
                withSonarQubeEnv('YourSonarQubeEnvironment') {
                    // Assuming Maven project, for others use the respective command
                    // The paths are examples; adjust them according to your project structure
                    sh """
                    mvn sonar:sonar \
                       -Dsonar.projectKey=YourProjectKey \
                       -Dsonar.host.url=http://yourSonarQubeServerURL \
                       -Dsonar.login=YourSonarQubeToken \
                       -Dsonar.java.source=1.8 \
                       -Dsonar.sources=src/main/java \
                       -Dsonar.tests=src/test/java \
                       -Dsonar.junit.reportPaths=target/surefire-reports \
                       -Dsonar.jacoco.reportPaths=target/jacoco.exec \
                       -Dsonar.java.checkstyle.reportPaths=target/checkstyle-result.xml
                    """
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    script {
                        def qg = waitForQualityGate()
                        if (qg.status != 'OK') {
                            error "Pipeline aborted due to quality gate failure: ${qg.status}"
                        }
                    }
                }
            }
        }
    }
}

```
##### Key Properties Explained:
- `sonar.java.source`: The version of Java your source code complies with. Adjust this based on your project.

- `sonar.sources`: Comma-separated paths to directories containing main source files.

- `sonar.tests`: Comma-separated paths to directories containing test source files.

- `sonar.junit.reportPaths`: Path to the directory containing JUnit XML report files. These reports are generated by the Surefire plugin during mvn test or mvn verify.

- `sonar.jacoco.reportPaths`: Path to JaCoCo coverage reports. Note that newer versions of SonarQube and JaCoCo might use different properties (like sonar.coverage.jacoco.xmlReportPaths) for XML format coverage reports.

- `sonar.java.checkstyle.reportPaths`: Path to the CheckStyle XML report. This assumes you're generating a CheckStyle report as part of your build process.



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
 Pipeline: We start with the main block which is pipeline. Everything comes inside the pipeline block. This will be executed by Jenkins. In pipeline we have agent, tools, environment, stages.
  - Node/Agent: You can define where this pipeline can get executed on which node or agent
  - Tools: From your global tool configuration if you have included some tools, then you can mention them here; like SonarScanner, or Maven or JDK.
  - Environment: This is the environment variables
  -  Stages: Steps that we want to execute in our job. Here we can have multiple stages
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

Now go to jenkins and run this, 
- click new item, name, select pipeline, paste the script above and run
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
