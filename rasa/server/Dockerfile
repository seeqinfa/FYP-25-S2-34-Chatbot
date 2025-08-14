# rasa/server/Dockerfile
FROM rasa/rasa:3.6.21-full

WORKDIR /app

COPY . /app

# Install additional Python dependencies for Rasa server (if any)
RUN pip install --no-cache-dir --upgrade -r requirements-rasa.txt

RUN rasa train

EXPOSE 5005

CMD ["rasa", "run", "--enable-api", "--cors", "*", "--port", "5005"]