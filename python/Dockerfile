# Use official Python image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy service code and requirements
COPY requirements.txt requirements.txt
COPY search.py search.py

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose port
EXPOSE 5000

# Run the service
CMD ["python", "search.py"]