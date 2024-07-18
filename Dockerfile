# Use a minimal Debian base image
FROM debian:latest

# Set the working directory in the container
WORKDIR /app

# Install Python and pip
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    apt-get clean

# Copy the current directory contents into the container at /app
ADD . /app

# Install the required packages from requirements.txt
RUN pip3 install --upgrade pip && \
    pip3 install --no-cache-dir -r requirements.txt

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Define environment variable
ENV NAME PasswordVerification

# Run app.py when the container launches
CMD ["python3", "app.py"]
