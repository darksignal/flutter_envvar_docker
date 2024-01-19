# Step 1 - Install dependencies and build the app
FROM ubuntu:latest AS builder

ARG VARC
ARG VARF

RUN apt-get update
RUN apt-get install -y bash curl file git unzip xz-utils zip libglu1-mesa
RUN apt-get clean

# Clone the flutter repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Set flutter path
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Start to run Flutter commands
# doctor to see if all was installs are ok
RUN flutter doctor -v
# Change stable channel
RUN flutter channel stable
# Enable web capabilities
RUN flutter config --enable-web
RUN flutter upgrade

# Copy files to NEW container and build
RUN mkdir /app
COPY . /app
WORKDIR /app
RUN flutter clean
RUN flutter pub get
RUN flutter build web --dart-define=ENV_VAR1="${VARF}" --dart-define=ENV_VAR2="Flutter Build!!" --release

# Step 2 - Create the run-time image
FROM nginx:stable-alpine AS runtime

COPY ./nginx.conf /etc/nginx/conf.d/default.conf
#Copy the build folder from the previous stage
COPY --from=builder /app/build/web /usr/share/nginx/html
EXPOSE 5000