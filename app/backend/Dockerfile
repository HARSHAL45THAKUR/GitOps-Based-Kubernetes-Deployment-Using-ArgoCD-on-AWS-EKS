FROM python:3.11-slim

# System dependencies for building Python packages
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    build-essential \
    libpq-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy all app files
COPY . .

# Install Python dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Add non-root user
RUN useradd -m appuser && chown -R appuser /app
USER appuser

# Run the app
CMD ["python", "app.py"]
