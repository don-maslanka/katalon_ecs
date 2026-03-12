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

    stage('Inspect Repo') {
      steps {
        sh '''
          set -e

          echo "=== BASIC NODE INFO ==="
          hostname
          whoami
          pwd

          echo "=== REPO CONTENTS ==="
          ls -la
          echo
          find . -maxdepth 3 -type f | sort

          echo "=== LOOK FOR KATALON PROJECT FILE ==="
          find . -name "*.prj" -type f || true
        '''
      }
    }

  }

}
