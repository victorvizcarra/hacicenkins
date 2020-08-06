node {
    checkout scm

    def customImage = docker.build("yenigul/hacicenkins:${env.BUILD_ID}")
    customImage.push()
    customImage.push('latest')
}
