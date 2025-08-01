// Jenkinsfile for Salesforce CI/CD
// This pipeline validates a PR against the Salesforce org and deploys to the main branch.

properties([
    pipelineTriggers([
        githubPush(),
        // Uncomment this line if you have the GitHub Pull Request Builder plugin installed
        // It provides more robust PR-specific triggers.
        // pollSCM('H/2 * * * *')
    ])
])

pipeline {
    agent any

    environment {
        SF_USERNAME = credentials('SF_USERNAME')
        SF_CONSUMER_KEY = credentials('SF_CONSUMER_KEY')
        JWT_KEY_FILE = credentials('JWT_KEY_FILE')
        // Set the Salesforce instance URL. Use 'https://test.salesforce.com' for sandboxes.
        SF_INSTANCE_URL = 'https://login.salesforce.com'
    }

    stages {
        stage('Checkout Pull Request') {
            when {
                // This condition identifies a build triggered by a Pull Request
                // The 'when' block is used here to only run this stage for PRs
                // env.CHANGE_ID is provided by the GitHub Pull Request Builder plugin
                expression { env.CHANGE_ID != null }
            }
            steps {
                script {
                    echo "Checking out changes from Pull Request ${env.CHANGE_ID}"
                    // This command fetches the changes from the PR branch
                    // The branch name is provided by the plugin (e.g., env.BRANCH_NAME)
                    checkout scm
                }
            }
        }

        stage('Authenticate with Salesforce') {
            steps {
                echo "Authenticating with Salesforce using JWT Flow..."
                // Use a script block for better readability and to handle multiple commands
                script {
                    sh '''
                    sfdx auth:jwt:grant \
                        --clientid "$SF_CONSUMER_KEY" \
                        --jwtkeyfile "$JWT_KEY_FILE" \
                        --username "$SF_USERNAME" \
                        --instanceurl "$SF_INSTANCE_URL" \
                        --setalias jwt-org
                    '''
                }
            }
        }

        stage('Validate Pull Request Changes') {
            when {
                // This stage runs only when a Pull Request is being built
                expression { env.CHANGE_ID != null }
            }
            steps {
                echo "Validating PR changes against the Salesforce org..."
                script {
                    sh '''
                    # Convert the source files to the metadata format
                    sfdx force:source:convert --rootdir force-app --outputdir deploy_pkg
                    
                    # Run a validation deployment to check for errors without deploying
                    # -c flag is for 'checkOnly', -l RunAllTestsInOrg runs all tests
                    sfdx force:mdapi:deploy --checkonly --testlevel RunAllTestsInOrg --deploydir deploy_pkg --targetusername jwt-org --wait 30
                    '''
                }
            }
        }

        stage('Deploy to Salesforce') {
            when {
                // This stage runs only when a merge to the 'main' branch is pushed
                branch 'main'
            }
            steps {
                echo "Deploying merged changes to Salesforce org..."
                script {
                    sh '''
                    # Convert the source files to the metadata format
                    sfdx force:source:convert --rootdir force-app --outputdir deploy_pkg

                    # Deploy the package to the target org
                    # -l RunAllTestsInOrg ensures all tests pass before deployment
                    sfdx force:mdapi:deploy --testlevel RunAllTestsInOrg --deploydir deploy_pkg --targetusername jwt-org --wait 30
                    '''
                }
            }
        }
    }
    post {
        // Post actions, useful for cleaning up or sending notifications
        always {
            echo "Pipeline finished."
            // You can add cleanup steps here, e.g., deleting a temporary directory.
            // sh 'rm -rf deploy_pkg'
        }
    }
}
