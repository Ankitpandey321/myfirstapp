pipeline {
    agent any

    tools {
        jdk 'jdk21'
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

        stage('Build Java App') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Run Java App') {
            steps {
                sh 'java -jar target/myfirstapp-1.0.0.jar'
            }
        }
    }

    post {
        success {
            echo "✅ CI Pipeline SUCCESS - JAR built"
        }
        failure {
            echo "❌ CI Pipeline FAILED"
        }
        always {
            archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
        }
    }
}
