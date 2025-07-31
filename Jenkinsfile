pipeline {
    agent any

    environment {
        SFDX_CLI = 'C:\Users\asus\AppData\Roaming\npm\sfdx.cmd' // ⚠️ Change this path
        AUTH_FILE = 'sfdx-auth.txt'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                git branch: 'main', url: 'https://github.com/your-org/your-repo.git'
            }
        }

        stage('Authenticate with Salesforce') {
            steps {
                bat "\"${env.SFDX_CLI}\" auth:sfdxurl:store --sfdxurlfile ${env.AUTH_FILE} --setdefaultusername --setalias DevHub"
            }
        }

        stage('Validate Pull Request') {
            when {
                expression {
                    return env.CHANGE_ID != null
                }
            }
            steps {
                bat "\"${env.SFDX_CLI}\" force:source:deploy -c -p force-app --targetusername DevHub"
            }
        }

        stage('Deploy to Salesforce') {
            when {
                expression {
                    return env.CHANGE_ID == null
                }
            }
            steps {
                bat "\"${env.SFDX_CLI}\" force:source:deploy -p force-app --targetusername DevHub"
            }
        }
    }

    post {
        failure {
            echo 'Pipeline failed. Check logs above.'
        }
        success {
            echo 'Pipeline succeeded.'
        }
    }
}
