FROM ubuntu:22.04

ENV APP_HOME /app

WORKDIR $APP_HOME

COPY . $APP_HOME

RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common gcc && \
    add-apt-repository -y ppa:deadsnakes/ppa && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    python3.11 python3-distutils python3-pip python3-apt && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND=noninteractive
RUN ln -fs /usr/share/zoneinfo/Asia/Kolkata /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN python3.11 -m pip install --no-cache-dir -r $APP_HOME/requirements.txt

## Build phase
RUN python3.11 $APP_HOME/train.py

RUN chmod +x entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/app/entrypoint.sh"]
