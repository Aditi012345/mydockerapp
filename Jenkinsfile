pipeline {
    agent any
    
    environment {
        IMAGE_NAME = 'mydockerapp'
        DOCKER_HUB_USER = 'YOUR_DOCKERHUB_USERNAME'  // Change this to your Docker Hub username
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/YOUR_GITHUB_USERNAME/mydockerapp.git'  // Change this
            }
        }
        
        stage('Build Docker Image') {
            steps {
                bat "docker build -t %DOCKER_HUB_USER%/%IMAGE_NAME%:latest ."
            }
        }
        
        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', 
                                                  usernameVariable: 'USERNAME', 
                                                  passwordVariable: 'PASSWORD')]) {
                    bat "docker login -u %USERNAME% -p %PASSWORD%"
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                bat "docker push %DOCKER_HUB_USER%/%IMAGE_NAME%:latest"
            }
        }
    }
    
    post {
        success {
            echo "Docker image successfully built and pushed to Docker Hub!"
        }
        failure {
            echo "Pipeline failed. Check console output for details."
        }
    }
}