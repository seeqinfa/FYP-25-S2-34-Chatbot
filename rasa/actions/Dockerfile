# rasa/actions/Dockerfile
FROM python:3.8-slim-buster

WORKDIR /app

# Copy the actions directory into the container
# This assumes your actions.py and __init__.py are in rasa/actions/actions/
COPY actions /app/actions

# Copy the requirements file
COPY requirements-actions.txt /app/

# Upgrade pip to latest version
RUN pip install --upgrade pip

# Install dependencies
RUN pip install --no-cache-dir -r requirements-actions.txt

EXPOSE 5055

CMD ["rasa", "run", "actions", "--port", "5055"]
