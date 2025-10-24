pipeline {
    // 1. Agent: Run on any available agent
    agent any

    // 2. Environment Variables: Define variables once for clarity
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
                // Pulls the code from the specified repository and branch
                git branch: 'main', url: 'https://github.com/Aditi012345/mydockerapp'
            }
        }

        stage('2. Build Docker Image') {
            steps {
                echo "Building image ${env.DOCKER_HUB_USER}/${env.IMAGE_NAME}:latest"
                // Uses Groovy interpolation (${env.VARIABLE}) for defined environment vars
                sh "docker build -t ${env.DOCKER_HUB_USER}/${env.IMAGE_NAME}:latest ."
            }
        }

        stage('3. Login to Docker Hub') {
            steps {
                // IMPORTANT: This block securely retrieves the credentials.
                // It injects the username and password as temporary environment variables
                // named USERNAME and PASSWORD, which prevents special character errors (like the '#').
                withCredentials([
                    usernamePassword(
                        credentialsId: env.DOCKER_CRED_ID,
                        usernameVariable: 'USERNAME',
                        passwordVariable: 'PASSWORD'
                    )
                ]) {
                    echo 'Attempting secure login to Docker Hub...'
                    // Access the temporary credential variables directly (no 'env.')
                    sh "docker login -u ${USERNAME} -p ${PASSWORD}"
                }
            }
        }

        stage('4. Push Docker Image') {
            steps {
                echo 'Pushing image to repository...'
                // Uses Groovy interpolation for the push command
                sh "docker push ${env.DOCKER_HUB_USER}/${env.IMAGE_NAME}:latest"
            }
        }
    }

    // Post-actions run after all stages
    post {
        success {
            echo "SUCCESS: Docker image successfully built and pushed to Docker Hub!"
        }
        failure {
            echo "FAILURE: Pipeline failed. Check console output and logs for details."
        }
        always {
            // Good practice: log out of Docker Hub when finished
            sh 'docker logout'
        }
    }
}
