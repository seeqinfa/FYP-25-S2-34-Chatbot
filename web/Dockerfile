# Use the correct FrankenPHP base image from dunglas/frankenphp
FROM dunglas/frankenphp:latest-php8.2-alpine

# Set the working directory inside the container to /app
# This is where your application files will reside
WORKDIR /app

# Copy all contents from the current build context (which is 'web/') into the /app directory in the container.
COPY . .

# Install PHP extensions required for your application.
RUN docker-php-ext-install pdo_mysql mysqli

# Copy your custom php.ini settings into the PHP configuration directory.
COPY php.ini /usr/local/etc/php/conf.d/custom.ini

# Expose the default port FrankenPHP listens on (2019)
EXPOSE 2019

# Define the command to run the FrankenPHP server when the container starts.
CMD ["frankenphp", "php-server"]
