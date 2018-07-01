# This Dockerfile is used for Binder only. Dockerfile for tests and
# builds is in docker directory.

FROM joommf/oommf

RUN apt-get update -y
RUN apt-get install -y python3-pip

COPY . /usr/local/joommf/
WORKDIR /usr/local/joommf
RUN python3 -m pip install .

# Commands to make Binder work.
RUN python3 -m pip install --no-cache-dir notebook==5.*
ENV NB_USER binderuser
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
RUN chown -R ${NB_UID} /usr/local/joommf
USER ${NB_USER}