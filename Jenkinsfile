pipeline {

  agent { label 'katalon-ecs' }

  options {
    timestamps()
  }

  stages {

    stage('Checkout Source') {
      steps {
        checkout scm
      }
    }

    stage('ECS Smoke Test') {
      steps {
        sh '''
          set -e

          echo "=== BASIC NODE INFO ==="
          hostname
          whoami
          pwd

          echo "=== WORKSPACE CONTENTS ==="
          ls -la

          echo "=== JAVA ==="
          java -version || true

          echo "=== KATALON ==="
          which katalonc || true
          katalonc -version || true

          echo "=== ENVIRONMENT ==="
          env | sort
        '''
      }
    }

  }
}
