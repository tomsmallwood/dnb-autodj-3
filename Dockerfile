FROM ubuntu:16.04

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# Install apt
RUN apt update
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa

# Install apt-get requirements
RUN apt-get update
RUN apt-get install -y gcc

# Python 3 requirements:
RUN apt-get install -y --upgrade python3.6 python3-pip python3.6-dev python-dev
RUN apt-get install -y libasound-dev libportaudio2 libportaudiocpp0
RUN apt-get install -y ffmpeg libav-tools

# https://stackoverflow.com/questions/44538746/cannot-install-pyaudio-0-2-11-in-ubuntu-16-04
RUN apt-get install -y build-essential portaudio19-dev
RUN apt-get install -y python-all-dev python3-all-dev

RUN rm -rf /var/lib/apt/lists/*

# Upgrade pip and install setuptools
RUN python3.6 -m pip install -U --upgrade pip
RUN python3.6 -m pip install -U --upgrade setuptools wheel

# Install dnb-autodj and pip requirements
WORKDIR /app
COPY . /app
RUN python3.6 -m pip install -U ./

# Configuring non-root user
RUN addgroup --gid 1000 appuser && \
  adduser --uid 1000 --ingroup appuser --home /home/appuser --shell /bin/sh --disabled-password --gecos "" appuser
RUN chown -R appuser:appuser /app

# HARD-CODED! Create group using host's guid (required for VirtualBox shared folders owned by vboxsf group)
RUN groupmod -g 999 appuser

# Switching to a non-root user, please refer to https://aka.ms/vscode-docker-python-user-rights
USER appuser:appuser

# Run app in /app/music to save export ./mix_{}.wav to local file
WORKDIR /app/music

RUN ["chmod", "+x", "/app/entrypoint.sh"]
ENTRYPOINT ["/app/entrypoint.sh"]