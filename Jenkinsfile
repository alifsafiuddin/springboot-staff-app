pipeline {
    agent {
        docker {
            image 'docker:24.0.2-dind'
            args '-u root --privileged -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        COMPOSE_PROJECT_NAME = 'springboot-staff-app'
    }

    stages {
        stage('Install Tools') {
            steps {
                sh 'apk add --no-cache openjdk17 maven docker-compose'
            }
        }

        stage('Build App') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Rebuild & Restart App') {
            steps {
                sh '''
                docker-compose down
                docker-compose up --build -d
                '''
            }
        }
    }

    post {
        always {
            echo "App and MySQL deployed with docker-compose."
        }
    }
}
