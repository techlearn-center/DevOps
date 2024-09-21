```
sudo apt update
```

```
sudo apt search jdk
```

```
sudo apt install openjdk-17-jdk -y
```

```
java --version
```

```
sudo apt install maven -y
```

```
mvn --version
```

Here’s a step-by-step guide to setting up Maven 3 in Jenkins, written in Markdown format for GitHub:

```markdown
# Jenkins Maven 3 Setup

This guide will walk you through the steps to set up Maven 3 in Jenkins for your build environment.

## Step 1: Install Maven in Jenkins

1. **Go to Jenkins Dashboard**  
   Navigate to your Jenkins dashboard.

2. **Access Global Tool Configuration**  
   On the left-hand menu, click on **Manage Jenkins** > **Global Tool Configuration**.

3. **Add Maven Installation**  
   Scroll down to the **Maven** section and click **Add Maven**.

4. **Name the Maven Installation**  
   In the **Name** field, enter a name for this Maven installation (e.g., `Maven3`). This name will be used in your Jenkins pipeline configuration.

5. **Install Automatically**  
   Check the box for **Install automatically**. In the drop-down menu, select the desired version of Maven (choose `3.x.x` for Maven 3). If you want to use a pre-installed version, uncheck this box and provide the path to the Maven installation in the **Maven Home** field.

6. **Save the Configuration**  
   Once done, click **Save**.

---

## Step 2: Configure Maven in Jenkins Pipeline

To use Maven in your Jenkins pipeline, follow these steps:

1. **Go to Your Pipeline Project**  
   Navigate to the pipeline project in Jenkins.

2. **Configure the Pipeline**  
   In the pipeline section of your project, you will need to reference the Maven installation by the name you specified during the setup (e.g., `Maven3`).

3. **Add Maven to Jenkinsfile**  
   In your Jenkinsfile, add the Maven tool to your pipeline script. Below is an example:

   ```groovy
   pipeline {
       agent any
       tools {
           maven 'Maven3' // Name of Maven installation in Jenkins
       }
       stages {
           stage('Build') {
               steps {
                   // Run Maven build
                   sh 'mvn clean install'
               }
           }
       }
   }
   ```

4. **Run Your Build**  
   Save the configuration and run your pipeline build. Jenkins will now use Maven 3 to run your build.

---

## Step 3: Verify the Setup

1. **Check the Build Logs**  
   After running the build, you can view the console output to ensure that Maven 3 is being used. Look for entries in the logs such as:

   ```
   [INFO] Apache Maven 3.x.x
   ```

2. **Verify Successful Build**  
   If everything is configured correctly, your build will succeed, and Maven will compile and package your code as defined in your `pom.xml` file.

---

## Troubleshooting

- **Maven Version Mismatch**: If the wrong version of Maven is used, double-check the version you selected in the Global Tool Configuration.
- **Missing `mvn` Command**: Ensure that Maven is properly installed and available in the system path if you're using a manually installed version.
- **Build Failures**: Check the console logs for any Maven-specific errors related to dependency resolution or project configuration.
```

This document provides clear steps for setting up Maven 3 in Jenkins and is formatted for easy integration into a GitHub repository as a `README.md` file.
