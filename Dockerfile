FROM jenkins/jenkins:lts

USER root

# Install Python
RUN apt-get update && \
    apt-get install -y python3 python3-pip

# Optionally, create a symlink for `python` to `python3`
RUN ln -s /usr/bin/python3 /usr/bin/python

USER jenkins
