pipeline {
    agent any

    environment {
        DOCKER_HUB_USER = 'Aditi012345'
        IMAGE_NAME = 'mydockerapp'
        DOCKER_CRED_ID = 'dockerhub-cred'
        
        // NEW: Define the full repository name including the registry prefix (docker.io is for Docker Hub)
        FULL_IMAGE_TAG = "docker.io/${DOCKER_HUB_USER}/${IMAGE_NAME}:latest"
    }

    stages {
        stage('1. Checkout Code') {
            steps {
                echo 'Starting code checkout from GitHub...'
                git branch: 'main', url: 'https://github.com/Aditi012345/mydockerapp'
            }
        }

        stage('2. Build Docker Image') {
            steps {
                echo "Building image ${env.FULL_IMAGE_TAG}"
                // Build the image with the full, explicit tag
                bat "docker build -t ${env.FULL_IMAGE_TAG} ."
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
                    // Use %VARIABLE% for injected credentials in 'bat'
                    bat "docker login -u %USERNAME% -p %PASSWORD%"
                }
            }
        }

        stage('4. Push Docker Image') {
            steps {
                echo 'Pushing image to repository...'
                // Push the image using the full, explicit tag
                bat "docker push ${env.FULL_IMAGE_TAG}"
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
            bat 'docker logout'
        }
    }
}
