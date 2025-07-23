pipeline {
    agent {
        docker {
            image 'docker:24.0.2-dind'
            args '-u root --privileged -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        IMAGE_NAME = 'springboot-staff-app'
        CONTAINER_NAME = 'springboot-staff-container'
    }

    stages {
        stage('Install Java & Maven, then Build JAR') {
            steps {
                sh '''
                apk add --no-cache openjdk17 maven
                mvn clean package -DskipTests
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Stop & Remove Existing Container') {
            steps {
                sh '''
                docker rm -f $CONTAINER_NAME || true
                '''
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                docker run -d -p 8080:8080 --name $CONTAINER_NAME $IMAGE_NAME
                '''
            }
        }
    }
}
