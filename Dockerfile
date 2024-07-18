# Use the official Jenkins image as the base image
FROM jenkins/jenkins:lts

# Switch to the root user to install dependencies
USER root

# Update the package list and install Python
RUN apt-get update && \
    apt-get install -y python3 python3-pip

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

# Install any needed packages specified in requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Define environment variable
ENV NAME PasswordVerification

# Switch back to the Jenkins user
USER jenkins

# Run app.py when the container launches
CMD ["python3", "app.py"]
