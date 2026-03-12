pipeline {

  agent { label 'katalon-ecs' }

  options {
    timestamps()
  }

  environment {
    KATALON_PROJECT_PATH = "."
    TEST_SUITE_PATH      = "Test Suites/Smoke"
    EXEC_PROFILE         = "default"
    BROWSER              = "Chrome"
  }

  stages {

    stage('Checkout Source') {
      steps {
        checkout scm
      }
    }

    stage('Verify Environment') {
      steps {
        sh '''
          set -e
          echo "=== BASIC NODE INFO ==="
          hostname
          whoami
          pwd

          echo "=== JAVA ==="
          java -version || true

          echo "=== KATALON ==="
          which katalonc || true
          katalonc -version || true
        '''
      }
    }

    stage('Run Katalon Tests') {
      steps {
        withCredentials([string(credentialsId: 'katalon-api-key', variable: 'KATALON_API_KEY')]) {
          sh '''
            set -e

            katalonc \
              -noSplash \
              -runMode=console \
              -projectPath="${KATALON_PROJECT_PATH}" \
              -testSuitePath="${TEST_SUITE_PATH}" \
              -executionProfile="${EXEC_PROFILE}" \
              -browserType="${BROWSER}" \
              -apiKey="${KATALON_API_KEY}" \
              -retry=0
          '''
        }
      }
    }

  }

  post {
    always {
      archiveArtifacts artifacts: '**/Reports/**', allowEmptyArchive: true
      junit testResults: '**/*.xml', allowEmptyResults: true
    }
  }

}
