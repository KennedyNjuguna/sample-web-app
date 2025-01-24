pipeline {
    agent any

    environment {
        IMAGE_NAME = 'kennjuguna/sample-web-app'
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'
        CLOUD_SERVER_IP = '3.85.86.106'
        SSH_CREDENTIALS_ID = 'ssh-credentials-id'
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
                sshagent(['ssh-credentials-id']) {
                    script {
                        sh '''
                        ssh -o StrictHostKeyChecking=no -i C:/Users/user/Downloads/user1.pem ec2-user@3.85.86.106 << EOF
                        docker pull ${IMAGE_NAME}:${BUILD_NUMBER}
                        docker stop your-container || true
                        docker rm your-container || true
                        docker run -d --name your-container -p 80:80 ${IMAGE_NAME}:${BUILD_NUMBER}
                        EOF
                        '''
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
