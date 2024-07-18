# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

# Install virtualenv
RUN pip install --no-cache-dir virtualenv

# Create and activate a virtual environment
RUN virtualenv venv
ENV VIRTUAL_ENV /app/venv
ENV PATH "$VIRTUAL_ENV/bin:$PATH"

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Define environment variable
ENV NAME PasswordVerification

# Run app.py when the container launches
CMD ["python", "app.py"]
