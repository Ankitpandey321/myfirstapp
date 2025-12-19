pipeline {
    agent any

    tools {
        jdk 'jdk21'
    }

    environment {
        IMAGE_NAME = "myfirstapp"
        IMAGE_TAG  = "${BUILD_NUMBER}"
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

        /* ---------- CI ---------- */
        stage('Build Java App') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        /* ---------- CD ---------- */
        stage('Build Container Image') {
            steps {
                sh 'docker build --tls-verify=false -t myfirstapp:${BUILD_NUMBER} .'
            }
        }


        stage('Run Container') {
            steps {
                sh '''
                    docker rm -f myfirstapp || true
                    docker run -d --name myfirstapp $IMAGE_NAME:$IMAGE_TAG
                '''
            }
        }
    }

    post {
        success {
            echo "✅ CI → CD Pipeline SUCCESS"
        }
        failure {
            echo "❌ CI → CD Pipeline FAILED"
        }
        always {
            archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
        }
    }
}
