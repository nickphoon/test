# Use a minimal Debian base image
FROM debian:latest

# Set the working directory in the container
WORKDIR /app

# Install necessary dependencies including Python, python3-venv, and several Python-related packages.
RUN apt-get update && apt-get install -y --no-install-recommends \
    binutils ca-certificates curl git python3 python3-venv python3-pip python3-setuptools python3-wheel python3-dev wget \
    && rm -rf /var/lib/apt/lists/*

# Create an alias for python3 as python.
RUN ln -s /usr/bin/python3 /usr/bin/python

# Copy the current directory contents into the container at /app
COPY . /app

# Create a Python virtual environment in /opt/venv.
RUN python3 -m venv /opt/venv

# Activate the virtual environment by adding its bin directory to the PATH.
# This ensures that the virtual environment is activated for all subsequent RUN commands in the Dockerfile.
ENV PATH="/opt/venv/bin:$PATH"

# Install required Python packages in the virtual environment.
RUN /opt/venv/bin/pip install --upgrade pip

# Define environment variable
ENV NAME Test

# Run app.py when the container launches
CMD ["python3", "app.py"]
