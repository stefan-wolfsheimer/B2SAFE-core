pipeline
{
    agent any
    parameters {
        string(name: 'prefix', defaultValue: "", description: 'Prefix for target yum repo')
    }
    environment {
        REPO_PREFIX = 'test_'
        YUM_SERVER = 'software@software.irodspoc-sara.surf-hosted.nl'
        SSH_OPTIONS = '-oStrictHostKeyChecking=no'
    }

    stages
    {
        stage('Build_4.2.6')
        {
            steps
            {
                echo '-------------'
                echo 'Shutting down'
                echo '-------------'
                sh './ci/shutdownall.sh'

                echo '----------------------------'
                echo 'Building against iRODS 4.2.6'
                echo '----------------------------'
                sh './ci/build.sh centos7_4_2_6'

            }
        }
        stage('Build_4.1.12')
        {
            steps
            {
                echo '-------------'
                echo 'Shutting down'
                echo '-------------'
                sh './ci/shutdownall.sh'

                echo '-----------------------------'
                echo 'Building against iRODS 4.1.12'
                echo '-----------------------------'
                sh './ci/build.sh centos7_4_1_12'
            }

        }
        stage('Test_4.2.6')
        {
            steps
            {
                echo '----------------------------'
                echo 'Testing against iRODS 4.2.6 '
                echo '----------------------------'
                echo './ci/test.sh centos7_4_2_6'
            }
        }
        stage('Test_4_1_12')
        {
            steps
            {
                echo '-----------------------------'
                echo 'Testing against iRODS 4.1.12'
                echo '-----------------------------'
                echo './ci/test.sh centos7_4_1_12'
            }
        }

        stage('Deploy_4_1_12')
        {
            steps
            {
                echo '------------------------------'
                echo 'Deploying.'
                sh './ci/deploy.sh centos7_4_1_12'
           }
        }
    }
}