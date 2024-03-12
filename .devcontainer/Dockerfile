ARG VARIANT="3.11-bullseye"
FROM mcr.microsoft.com/vscode/devcontainers/python:0-${VARIANT}

WORKDIR /workspaces/app
ARG WORKSPACE_FOLDER="/workspaces/app"

# Install program dependencies:

RUN mkdir /tmp/config_container

COPY /.devcontainer/install-deps.sh /tmp/config_container/install-deps.sh
RUN chmod +x /tmp/config_container/install-deps.sh
RUN /tmp/config_container/install-deps.sh

RUN rm -rvf /tmp/config_container

# Create virtual environment:
VOLUME $WORKSPACE_FOLDER/.venv

ENV WORKSPACE_PATH=$WORKSPACE_FOLDER

EXPOSE 57531
