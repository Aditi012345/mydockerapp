pipeline {
    agent any

    environment {
        // Replace with your Docker Hub username
        DOCKER_HUB_USER = 'Aditi012345'
        // Replace with your Docker image name
        IMAGE_NAME = 'mydockerapp'
        // Define the credential ID used in Jenkins
        DOCKER_CRED_ID = 'dockerhub-cred'
    }

    stages {
        stage('1. Checkout Code') {
            steps {
                echo 'Starting code checkout from GitHub...'
                // The 'git' step is a native pipeline command, so it needs no bat/sh prefix.
                git branch: 'main', url: 'https://github.com/Aditi012345/mydockerapp'
            }
        }

        stage('2. Build Docker Image') {
            steps {
                echo "Building image ${env.DOCKER_HUB_USER}/${env.IMAGE_NAME}:latest"
                // FIX: Switched 'sh' to 'bat'
                bat "docker build -t ${env.DOCKER_HUB_USER}/${env.IMAGE_NAME}:latest ."
            }
        }

        stage('3. Login to Docker Hub') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: env.DOCKER_CRED_ID,
                        usernameVariable: 'USERNAME',
                        passwordVariable: 'PASSWORD'
                    )
                ]) {
                    echo 'Attempting secure login to Docker Hub...'
                    // FIX: Switched 'sh' to 'bat'
                    // In a 'bat' script, use %VARIABLE% syntax for injected credentials.
                    bat "docker login -u %USERNAME% -p %PASSWORD%"
                }
            }
        }

        stage('4. Push Docker Image') {
            steps {
                echo 'Pushing image to repository...'
                // FIX: Switched 'sh' to 'bat'
                bat "docker push ${env.DOCKER_HUB_USER}/${env.IMAGE_NAME}:latest"
            }
        }
    }

    post {
        success {
            echo "SUCCESS: Docker image successfully built and pushed to Docker Hub!"
        }
        failure {
            echo "FAILURE: Pipeline failed. Check console output and logs for details."
        }
        always {
            // FIX: Switched 'sh' to 'bat'
            bat 'docker logout'
        }
    }
}
