# Dockerfile for Render deployment
FROM python:3.11-slim-buster

# Install system dependencies
RUN apt-get update && apt-get install -y \
    ffmpeg \
    wget \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements first for better caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy bot files
COPY . .

# Create cache directory
RUN mkdir -p /app/cache

# Expose health check port
EXPOSE 8000

# Run the bot
CMD ["python", "music_bot.py"]
