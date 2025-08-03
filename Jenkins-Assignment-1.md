
# 🛠️ Jenkins Intro Assignment

## 🎯 Objective
Set up Jenkins using an automation script from a GitHub project, fork the repo to your personal GitHub account, and build a simple Jenkins pipeline that runs a basic job.

---

## 📌 Assignment Steps

### 1. Fork and Clone the Repository
- Go to the GitHub repo:  
  [https://github.com/techlearn-center/DevOps/tree/e2e-3-tier-DevSecOps](https://github.com/techlearn-center/DevOps/tree/e2e-3-tier-DevSecOps)
- Click **“Fork”** to copy the project into your own GitHub account.
- Clone the forked repo to your local machine:
  ```bash
  git clone https://github.com/<your-username>/DevOps.git
  cd DevOps  # or the name of your forked repo if renamed
git checkout e2e-3-tier-DevSecOps
  ```

---

### 2. Spin Up Jenkins on an EC2 Instance (Ubuntu-based)
- Ensure you have access to an AWS account and have configured your key pair and IAM roles properly.
- Use the provided **Terraform files** under `Jenkins-Server-TF` to provision your EC2 instance.
- Navigate into the folder:
  ```bash
  cd Jenkins-Server-TF
  ```
- Run:
  ```bash
  terraform init
  terraform plan
  terraform apply
  ```

---

### 3. Install Jenkins and Required Tools
- SSH into the created EC2 instance.
- Run the installation script:
  ```bash
  ./tools-install.sh
  ```
- This installs:
  - `kubectl`
  - `eksctl`
  - `Terraform`
  - `Trivy`
  - `Helm`
  - Jenkins

---

### 4. Access Jenkins
- Open your browser and go to `http://<your-ec2-public-ip>:8080`
- Unlock Jenkins using the initial password:
  ```bash
  sudo cat /var/lib/jenkins/secrets/initialAdminPassword
  ```
- Install suggested plugins and set up an admin user.

---

### 5. Push Project to Your GitHub
- Initialize Git (if not already):
  ```bash
  git init
  git remote add origin https://github.com/<your-username>/DevOps.git
  git push -u origin main
  ```

---

### 6. Create a Jenkins Pipeline Job
- In Jenkins, click **New Item** > **Pipeline**
- Name it: `my-first-pipeline`
- Under “Pipeline”, paste a simple script like:

  ```groovy
  pipeline {
    agent any
    stages {
      stage('Hello') {
        steps {
          echo 'Hello Jenkins!'
        }
      }
    }
  }
  ```

- Click **Save** and then **Build Now**

---

## ✅ Deliverables
- ✅ Forked repo on your GitHub account with README updated with your name.
- ✅ Screenshot of Jenkins setup (dashboard and build success).
- ✅ Working pipeline job in Jenkins.
- ✅ Share your GitHub link and Jenkins pipeline screenshot in your submission.

---

## ➕ Extra: Add a Simple Jenkinsfile and Configure Jenkins to Build It

### 🔧 7. Add a Jenkinsfile to the Root of Your Repo

In the root directory of your cloned project, create a file named `Jenkinsfile` with the following content:

```groovy
pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        echo 'Building the application...'
      }
    }
    stage('Test') {
      steps {
        echo 'Running tests...'
      }
    }
    stage('Deploy') {
      steps {
        echo 'Deploying application...'
      }
    }
  }
}
```

- This is a basic pipeline that just echoes messages in each stage.

---

### 📁 8. (Optional) Add a Simple `pom.xml` File (for Java Projects)

If you're simulating a Java project, create a minimal `pom.xml` file:

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.example</groupId>
    <artifactId>demo-app</artifactId>
    <version>1.0-SNAPSHOT</version>
</project>
```

---

### ⚙️ 9. Set Up Jenkins to Build from the Jenkinsfile

- Go to Jenkins dashboard → **New Item**
- Enter a name (e.g., `simple-pipeline`), choose **Pipeline**, then click OK.
- Scroll to **Pipeline** section:
  - Select **Pipeline script from SCM**
  - SCM: **Git**
  - Repository URL: `https://github.com/<your-username>/DevOps.git`
  - Branch: `main`
  - Script Path: `Jenkinsfile`

Click **Save**, then **Build Now**.

---

## ✅ Updated Deliverables

- ✅ Forked and modified repo with a Jenkinsfile in the root.
- ✅ Optional: Add a `pom.xml` if simulating a Java Maven project.
- ✅ Jenkins pipeline configured to pull and build from GitHub.
- ✅ Screenshots of Jenkins job setup and successful build run.
