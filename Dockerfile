# Use official Python image
FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    gcc \
    g++ \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Downgrade pip for compatibility with old packages
RUN pip install "pip<24.1" setuptools==58.1.0 wheel

# Copy your requirements
COPY requirements.txt .

# Install Python dependencies
RUN pip install -r requirements.txt

# Copy the app
COPY app.py .

# Expose port and run
EXPOSE 8000
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:8000", "app:app"]
