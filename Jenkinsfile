pipeline {
    agent any

    /* Explicitly tell Jenkins to use Java 21 */
    tools {
        jdk 'jdk21'          // This must be configured in Jenkins Global Tool Configuratio
    }

    environment {
        APP_NAME   = "myfirstapp"
        IMAGE_NAME = "myrepo/myfirstapp"
        IMAGE_TAG  = "${BUILD_NUMBER}"
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Verify Java Version') {
            steps {
                sh '''
                echo "JAVA_HOME=$JAVA_HOME"
                java -version
                mvn -version
                '''
            }
        }

        stage('Build Java App (Java 21)') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh """
                docker build -t $IMAGE_NAME:$IMAGE_TAG .
                """
            }
        }

        stage('Push Docker Image') {
            steps {
                sh """
                docker push $IMAGE_NAME:$IMAGE_TAG
                """
            }
        }
    }

    post {

        success {
            echo "✅ Build SUCCESS: Java 21 app built and image pushed successfully"
        }

        failure {
            echo "❌ Build FAILED: Please check logs"
        }

        always {
            echo "ℹ️ Pipeline finished at ${new Date()}"
            archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
        }
    }
}
