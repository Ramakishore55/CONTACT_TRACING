pipeline {
    agent any

    environment {
        SF_USERNAME = credentials('SF_USERNAME') // From Jenkins credentials
        SF_CONSUMER_KEY = credentials('SF_CONSUMER_KEY') // From Connected App
        JWT_KEY_FILE = credentials('JWT_KEY_FILE') // server.key file
    }

    stages {
        stage('Authenticate with Salesforce') {
            steps {
                sh '''
                sfdx auth:jwt:grant \
                    --clientid $SF_CONSUMER_KEY \
                    --jwtkeyfile $JWT_KEY_FILE \
                    --username $SF_USERNAME \
                    --instanceurl https://login.salesforce.com \
                    --setalias DevOrg
                '''
            }
        }

        stage('Validate Pull Request') {
            when {
                expression { env.CHANGE_ID != null } // only runs on PRs
            }
			steps
            steps {
                sh '''
                sfdx force:source:convert -d deploy_pkg
                sfdx force:mdapi:deploy -u DevOrg -d deploy_pkg -c -w 10
                '''
            }
        }

        stage('Deploy to Salesforce') {
            when {
                branch 'main' // only runs when PR is merged to main
            }
            steps {
                sh '''
                sfdx force:source:convert -d deploy_pkg
                sfdx force:mdapi:deploy -u DevOrg -d deploy_pkg -w 10
                '''
            }
        }
    }
}
