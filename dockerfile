# Use a lightweight Python image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy only necessary files
COPY src/app/helloworld.py requirements.txt ./

# Install dependencies
RUN pip install --no-cache-dir flask

# Expose Flask port
EXPOSE 3300

# Run the Flask app
CMD ["python", "helloworld.py"]