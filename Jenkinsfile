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
        MYSQL_CONTAINER = 'springboot-mysql'
        MYSQL_ROOT_PASSWORD = 'yourpassword'
        MYSQL_DB = 'testmysql'
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

        stage('Start MySQL Container') {
            steps {
                sh '''
                docker rm -f $MYSQL_CONTAINER || true
                docker run -d --name $MYSQL_CONTAINER \
                    -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
                    -e MYSQL_DATABASE=$MYSQL_DB \
                    -p 3306:3306 \
                    mysql:8
                '''
                // Wait for MySQL to be ready
                sh 'sleep 30'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Stop & Remove Existing App Container') {
            steps {
                sh 'docker rm -f $CONTAINER_NAME || true'
            }
        }

        stage('Run App Container') {
            steps {
                sh '''
                docker run -d -p 8080:8080 \
                    --name $CONTAINER_NAME \
                    --link $MYSQL_CONTAINER:mysql \
                    $IMAGE_NAME
                '''
            }
        }
    }
}
