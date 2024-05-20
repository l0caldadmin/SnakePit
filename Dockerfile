# Use a lightweight Python base image
FROM python:3.9-alpine

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file
COPY requirements.txt .

# Create the virtual environment
RUN python3 -m venv /app/.venv

# Activate the virtual environment
ENV PATH="/app/.venv/bin:$PATH"

# Install dependencies (including proxy.py)
RUN pip install --no-cache-dir --upgrade -r requirements.txt

# Copy the project code
COPY . .

# Make the script executable
#RUN chmod +x start.sh

# Expose the Flask app port and the proxy.py ports
EXPOSE 5000 8899 8888


#manual start
CMD ["sh", "-c", "source /app/.venv/bin/activate && nohup flask run --host=0.0.0.0 & proxy.py --enable-dashboard & wait"]