FROM katalonstudio/katalon:10-latest-slim

USER root

# Tools commonly needed for Katalon + CI
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      git \
      openssh-client \
      xvfb \
      curl \
      unzip \
      ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# AWS CLI v2 (optional but often useful)
RUN curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip" && \
    unzip -q /tmp/awscliv2.zip -d /tmp && \
    /tmp/aws/install && \
    rm -rf /tmp/aws /tmp/awscliv2.zip

# Jenkins agent bits
RUN mkdir -p /usr/share/jenkins
COPY jenkins-agent.sh /usr/local/bin/jenkins-agent
RUN chmod +x /usr/local/bin/jenkins-agent

ENV JENKINS_AGENT_WORKDIR=/workspace
WORKDIR /workspace

ENTRYPOINT ["/usr/local/bin/jenkins-agent"]
