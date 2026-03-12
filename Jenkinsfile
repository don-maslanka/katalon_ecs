pipeline {

  agent { label 'katalon' }

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
          echo "Node information"
          hostname
          whoami
          pwd

          echo "Java runtime"
          java -version || true

          echo "Katalon CLI"
          which katalonc || true
          katalonc -version || true
        '''
      }
    }

    stage('Run Katalon Tests') {
      steps {
        sh '''
          set -e

          katalonc \
            -projectPath="${KATALON_PROJECT_PATH}" \
            -testSuitePath="${TEST_SUITE_PATH}" \
            -executionProfile="${EXEC_PROFILE}" \
            -browserType="${BROWSER}" \
            -retry=0
        '''
      }
    }

  }

  post {

    always {

      echo "Archiving reports"

      archiveArtifacts artifacts: '**/Reports/**', allowEmptyArchive: true

      junit testResults: '**/*.xml', allowEmptyResults: true
    }
  }

}
