ARG VARIANT="3.11-bullseye"
FROM mcr.microsoft.com/vscode/devcontainers/python:0-${VARIANT}

WORKDIR /workspaces/app
ARG WORKSPACE_FOLDER="/workspaces/app"
ENV WORKSPACE_PATH=$WORKSPACE_FOLDER

# Prevent interactive popups when initializing debian.
ENV DEBIAN_FRONTEND=noninteractive

# Install OS packages
RUN sudo apt-get update && apt-get -yq install vim dos2unix

# Install python requirements
RUN mkdir /tmp/config_container
COPY /.devcontainer/requirements.txt /tmp/config_container/requirements.txt
RUN pip install --upgrade pip
RUN pip install -r /tmp/config_container/requirements.txt
RUN rm -rvf /tmp/config_container

# persist bash history between sessions
ARG USERNAME=vscode

RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" \
    && mkdir /commandhistory \
    && touch /commandhistory/.bash_history \
    && chown -R $USERNAME /commandhistory \
    && echo "$SNIPPET" >> "/home/$USERNAME/.bashrc"
