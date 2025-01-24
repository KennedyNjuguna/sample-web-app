pipeline {
    agent any

    environment {
        IMAGE_NAME = 'kennjuguna/sample-web-app'
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'
        CLOUD_SERVER_IP = '3.85.86.106'
        SSH_CREDENTIALS_ID = 'ssh-credentials-id'
        AWS_CREDENTIALS_ID = 'aws-credentials' // AWS credentials ID in Jenkins
        AWS_REGION = 'us-east-1' // Replace with your AWS region
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/KennedyNjuguna/sample-web-app.git',
                    credentialsId: 'Github-Credentials'
            }
        }

        stage('Build and Tag Docker Image') {
            steps {
                script {
                    sh 'docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} .'
                }
            }
        }

        stage('Push Image to DockerHub') {
            steps {
                withDockerRegistry([credentialsId: "${DOCKER_CREDENTIALS_ID}", url: '']) {
                    sh 'docker push ${IMAGE_NAME}:${BUILD_NUMBER}'
                }
            }
        }

        stage('Deploy to Cloud VM') {
            steps {
                // Using AWS CLI to deploy Docker image to EC2 instance
                withCredentials([usernamePassword(credentialsId: "${AWS_CREDENTIALS_ID}", usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    script {
                        // SSH command to EC2 using AWS CLI and Docker
                        sh """
                        aws ec2 describe-instances --instance-ids i-xxxxxxxx --region ${AWS_REGION} > instance_details.json
                        INSTANCE_PUBLIC_IP=\$(jq -r '.Reservations[0].Instances[0].PublicIpAddress' instance_details.json)

                        # Use the public IP to SSH into the EC2 instance
                        ssh -o StrictHostKeyChecking=no -i C:/Users/user/Downloads/user1.pem ec2-user@\$INSTANCE_PUBLIC_IP << EOF
                        docker pull ${IMAGE_NAME}:${BUILD_NUMBER}
                        docker stop your-container || true
                        docker rm your-container || true
                        docker run -d --name your-container -p 80:80 ${IMAGE_NAME}:${BUILD_NUMBER}
                        EOF
                        """
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment Successful!'
        }
        failure {
            echo 'Deployment Failed!'
        }
    }
}
