#ARG BUILD_FROM="alpine:latest"
FROM python:3

ENV LANG C.UTF-8

# Copy data for add-on
COPY run.sh makeconf.sh rs485.py /

# Install requirements for add-on
RUN apt-get update && apt-get -y install jq
# RUN apt-get update && apt-get install -y python3-pip
RUN python3 -m pip install pyserial
RUN python3 -m pip install paho-mqtt
# RUN python3 -m pip install --upgrade paho-mqtt
RUN python3 -m pip install typing_extensions
# pip 설치 (필요한 경우)
# RUN apt-get update && apt-get install -y python3-pip

# 패키지 설치
# RUN pip install pyserial paho-mqtt typing_extensions

WORKDIR /share

RUN chmod a+x /makeconf.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
