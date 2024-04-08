FROM python:3.12-bookworm

COPY . /script

RUN pip install -r /script/requirements.txt

WORKDIR /workspace

ENTRYPOINT [ "python3", "/script/src/app.py" ]
