# Use a FrankenPHP base image with PHP 8.2
FROM frankenphp/frankenphp:latest-php8.2-alpine

# Set the working directory inside the container to /app
# This is where your application files will reside
WORKDIR /app

# Copy the entire 'web' directory content into the /app directory in the container.
# This assumes your Dockerfile is in the project root, and 'web' is a subdirectory
# containing all your PHP application files.
COPY web/ .

# Install PHP extensions required for your application.
# 'pdo_mysql' and 'mysqli' are essential for database connectivity.
# 'opcache' and 'sodium' are often built-in or automatically enabled in FrankenPHP images,
# so we typically don't need to explicitly install them here unless issues arise.
RUN docker-php-ext-install pdo_mysql mysqli

# Copy your custom php.ini settings into the PHP configuration directory.
# This ensures your specific PHP settings are applied.
COPY web/php.ini /usr/local/etc/php/conf.d/custom.ini

# Expose the default port FrankenPHP listens on (2019)
EXPOSE 2019

# Define the command to run the FrankenPHP server when the container starts.
# The default entrypoint of frankenphp images usually handles this,
# but explicitly setting CMD ensures it runs your application.
CMD ["frankenphp", "php-server"]
