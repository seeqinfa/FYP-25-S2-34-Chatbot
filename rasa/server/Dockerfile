# rasa/server/Dockerfile
FROM rasa/rasa:3.6.21-full

WORKDIR /app

COPY . /app

RUN rasa train

EXPOSE 5005

CMD ["rasa", "run", "--enable-api", "--cors", "*", "--port", "5005"]