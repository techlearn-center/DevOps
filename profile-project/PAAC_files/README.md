## CI/CD Pipeline with Jenkins, SonarQube, and Nexus

After following the steps in this repository to provision Jenkins, SonarQube, and Nexus on AWS EC2 instances using Terraform, you are now ready to start running your CI jobs with Jenkins. You can execute your pipelines in two ways:

1. **Pipeline as a Script**:  
   You can create a pipeline job in Jenkins and paste the `Jenkinsfile` directly into the **Pipeline Script** section. This is useful for running quick tests or setting up simple pipelines.

2. **Pipeline from SCM (Source Control Management)**:  
   This is a more robust and scalable approach where Jenkins fetches the pipeline script (`Jenkinsfile`) from the version control system (e.g., Git).  
   To configure this:
   - Go to Jenkins and create a **Pipeline** job.
   - Select **Pipeline from SCM** as the pipeline definition method.
   - Provide the repository URL and the branch where the `Jenkinsfile` is stored.
   - In the **Script Path** field, enter the path to the `Jenkinsfile` if it is not in the root directory of your repository.

### Example Jenkins Pipeline Configuration

```groovy
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                // Example build step
                sh 'mvn clean install'
            }
        }
        stage('Test') {
            steps {
                // Run unit tests
                sh 'mvn test'
            }
        }
        stage('Deploy to Nexus') {
            steps {
                // Deploy artifacts to Nexus
                sh 'mvn deploy'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                // SonarQube code analysis
                withSonarQubeEnv('MySonarQube') {
                    sh 'mvn sonar:sonar'
                }
            }
        }
    }
}
