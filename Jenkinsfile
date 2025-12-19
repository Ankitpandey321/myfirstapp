pipeline {
    agent any

    tools {
        jdk 'jdk21'
        maven 'maven3'
    }

    environment {
        APP_NAME = "myfirstapp"
        APP_VERSION = "1.0.0"
        DEPLOY_DIR = "/opt/apps/myfirstapp"
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Verify Java & Maven') {
            steps {
                sh '''
                  java -version
                  mvn -version
                '''
            }
        }

        stage('Build Application (CI)') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Archive Artifact') {
            steps {
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }

        stage('Deploy Application (CD)') {
            steps {
                sh '''
                  mkdir -p ${DEPLOY_DIR}
                  cp target/${APP_NAME}-${APP_VERSION}.jar ${DEPLOY_DIR}/
                '''
            }
        }

        stage('Run Application') {
            steps {
                sh '''
                  java -jar ${DEPLOY_DIR}/${APP_NAME}-${APP_VERSION}.jar &
                '''
            }
        }
    }

    post {
        success {
            echo "✅ CI → CD SUCCESS (JAR deployed)"
        }
        failure {
            echo "❌ CI → CD FAILED"
        }
    }
}
