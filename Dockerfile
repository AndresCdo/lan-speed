# Use an official Python runtime as a parent image
FROM python:3.9-slim-buster

# Set the working directory to /app
WORKDIR /app

# Copy the Bash script, Python script, and requirements.txt file into the container
COPY requirements.txt ./

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Install additional packages required for the script
RUN apt-get update && apt-get install -y \
    figlet \
    iputils-ping \
 && rm -rf /var/lib/apt/lists/*

RUN INTERFACE=$(ip a | cut -d' ' -f2 | xargs echo | rev | cut -d' ' -f1 | rev | cut -d':' -f1)

COPY lan-speed.sh analysis.py ./

# Make the Bash script executable
RUN chmod +x lan-speed.sh

# Run the Bash script when the container launches
ENTRYPOINT ["./lan-speed.sh"]
# CMD [ "$INTERFACE", "8.8.8.8" ]
