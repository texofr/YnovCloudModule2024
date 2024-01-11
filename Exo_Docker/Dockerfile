FROM debian:latest

RUN apt-get update && apt-get install -y --no-install-recommends python3

ADD file.py /example/file.py

WORKDIR /example/

CMD python3 file.py







