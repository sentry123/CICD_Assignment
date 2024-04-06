FROM ubuntu:22.04

ENV APP_HOME /app

WORKDIR $APP_HOME

COPY . $APP_HOME

# RUN apt-get update && apt-get install -y software-properties-common gcc && \
#     add-apt-repository -y ppa:deadsnakes/ppa

# RUN apt-get update && apt-get install -y python3.11 python3-distutils python3-pip python3-apt

# Set non-interactive frontend
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies including tzdata
RUN apt-get update && \
    apt-get install -y \
    software-properties-common gcc && \
    add-apt-repository -y ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y \
    python3.11 python3-distutils python3-pip python3-apt

# Reset non-interactive frontend
ENV DEBIAN_FRONTEND=

RUN python3 -m pip install --no-cache-dir -r $APP_HOME/requirements.txt

## Build phase
RUN python3 $APP_HOME/train.py

RUN chmod +x $APP_HOME/entrypoint.sh

EXPOSE 80

ENTRYPOINT $APP_HOME/entrypoint.sh
