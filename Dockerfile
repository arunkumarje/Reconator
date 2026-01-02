FROM python:3.10-slim-bullseye

WORKDIR /app

COPY requirements.txt .

COPY .gf /root/.gf

RUN apt-get update -y \
 && apt-get install -y --no-install-recommends gcc libcurl4-openssl-dev libc6-dev libssl-dev dnsutils \
 && rm -rf /var/lib/apt/lists/*

# 🔥 IMPORTANT: pin pip version (wfuzz fix)
RUN pip install "pip<24.1"

RUN pip install -r requirements.txt

COPY app.py .
COPY . .

ENV PYTHONWARNINGS=ignore

RUN chmod -R 777 .

CMD ["python", "app.py"]
