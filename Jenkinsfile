pipeline {
    // Defines where the pipeline will run (any available agent)
    agent any

    // Define environment variables accessible throughout the pipeline
    environment {
        IMAGE_NAME = 'mydockerapp'
        DOCKER_HUB_USER = 'Aditi012345'
    }

    // Stages define the main steps of the pipeline
    stages {
        stage('Checkout') {
            steps {
                // Pulls the code from the specified GitHub repository and branch
                git branch: 'main', url: 'https://github.com/Aditi012345/mydockerapp'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Use Groovy interpolation (${env.VARIABLE}) to securely pass environment variables to the bat command
                bat "docker build -t ${env.DOCKER_HUB_USER}/${env.IMAGE_NAME}:latest ."
            }
        }

        stage('Login to Docker Hub') {
            steps {
                // Retrieve credentials from Jenkins and inject them as environment variables
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-cred',
                        usernameVariable: 'Aditi012345',
                        passwordVariable: 'Aditi#3004'
                    )
                ]) {
                    // The injected environment variables (%USERNAME%, %PASSWORD%) are used by the bat command
                    bat "docker login -u Aditi012345 -p Aditi#3004
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                // Use Groovy interpolation (${env.VARIABLE}) for the push command
                bat "docker push ${env.DOCKER_HUB_USER}/${env.IMAGE_NAME}:latest"
            }
        }
    }

    // Post-actions run after the stages complete
    post {
        success {
            echo "Docker image successfully built and pushed to Docker Hub!"
        }
        failure {
            echo "Pipeline failed. Check console output for details."
        }
    }
}
