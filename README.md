
2. **Define the VPC**:
- Example `main.tf`:
  ```hcl
  module "vpc" {
    source = "terraform-aws-modules/vpc/aws"

    name = "my-vpc"
    cidr = "10.0.0.0/16"
    azs = ["us-east-1a", "us-east-1b"]
    public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]

    tags = {
      Terraform = "true"
      Environment = "dev"
    }
  }
  ```

3. **Define the EC2 Instance**:
- Example `main.tf` (continued):
  ```hcl
  module "ec2_instance" {
    source = "terraform-aws-modules/ec2-instance/aws"

    name = "sample-instance"
    ami = "ami-0c02fb55956c7d316" # Amazon Linux 2
    instance_type = "t2.micro"
    key_name = "your-key-pair"
    subnet_id = module.vpc.public_subnets[0]
  }
  ```

4. **Deploy the Infrastructure**:
- Initialize Terraform:
  ```bash
  terraform init
  ```
- Plan the deployment:
  ```bash
  terraform plan
  ```
- Apply the deployment:
  ```bash
  terraform apply
  ```

5. **Outputs**:
- Example `outputs.tf`:
  ```hcl
  output "instance_public_ip" {
    value = module.ec2_instance.public_ip
  }
  ```

---

## Task 4: CI/CD Pipeline with Cloud Integration (25%)

### **Objective**
Create a CI/CD pipeline to automate the deployment process.

### **Steps**

1. **Set Up Jenkins**:
- Install Jenkins and necessary plugins (e.g., Docker, Git).

2. **Pipeline Definition**:
- Create a `Jenkinsfile`:
  ```groovy
  pipeline {
      agent any
      stages {
          stage('Clone Repository') {
              steps {
                  git 'https://github.com/your-repo.git'
              }
          }
          stage('Build Docker Image') {
              steps {
                  sh 'docker build -t sample-web-app .'
              }
          }
          stage('Push to DockerHub') {
              steps {
                  withCredentials([string(credentialsId: 'dockerhub-credentials', variable: 'DOCKERHUB_TOKEN')]) {
                      sh '''
                      docker login -u your-dockerhub-username -p $DOCKERHUB_TOKEN
                      docker push your-dockerhub-username/sample-web-app
                      '''
                  }
              }
          }
          stage('Deploy to EC2') {
              steps {
                  sshagent(['ssh-key-id']) {
                      sh '''
                      ssh -o StrictHostKeyChecking=no ec2-user@<EC2-IP> \
                      "docker run -d -p 80:80 your-dockerhub-username/sample-web-app"
                      '''
                  }
              }
          }
      }
  }
  ```

3. **Test the Pipeline**:
- Run the pipeline in Jenkins and verify each stage.

![alt text](<Screenshot 2025-01-24 212636.png>)
![alt text](<Screenshot 2025-01-24 212719.png>)
---

## Additional Notes
- **Security**: Use `.gitignore` to exclude sensitive files such as SSH keys.
- **Documentation**: Document all steps clearly, including challenges and solutions.
