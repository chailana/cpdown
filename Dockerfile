FROM ubuntu:latest

# Update and install required dependencies, including python3-dev for building packages
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends gcc libffi-dev musl-dev ffmpeg aria2 python3-pip python3-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy application code to /app and set it as the working directory
COPY . /app/
WORKDIR /app/

# Copy the requirements.txt file and install Python dependencies
COPY requirements.txt /app/
RUN pip3 install --no-cache-dir --upgrade --requirement requirements.txt --break-system-packages

# Run the application
CMD gunicorn app:app & python3 main.py
