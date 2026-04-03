# Build stage
FROM debian:bookworm as builder

# Install Flutter dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Clone and install Flutter
RUN git clone https://github.com/flutter/flutter.git -b stable /flutter
ENV PATH="/flutter/bin:${PATH}"

# Run flutter doctor
RUN flutter doctor

# Set working directory
WORKDIR /app

# Copy app files
COPY . .

# Get dependencies and build web
RUN flutter pub get && \
    flutter build web --release \
    --dart-define=FIREBASE_API_KEY=${FIREBASE_API_KEY} \
    --dart-define=FIREBASE_APP_ID=${FIREBASE_APP_ID} \
    --dart-define=FIREBASE_MESSAGING_SENDER_ID=${FIREBASE_MESSAGING_SENDER_ID} \
    --dart-define=FIREBASE_PROJECT_ID=${FIREBASE_PROJECT_ID} \
    --dart-define=FIREBASE_AUTH_DOMAIN=${FIREBASE_AUTH_DOMAIN} \
    --dart-define=FIREBASE_STORAGE_BUCKET=${FIREBASE_STORAGE_BUCKET} \
    --dart-define=FIREBASE_MEASUREMENT_ID=${FIREBASE_MEASUREMENT_ID}

# Runtime stage
FROM node:20-slim

# Install http-server to serve the web app
RUN npm install -g http-server

# Set working directory
WORKDIR /app

# Copy built web app from builder
COPY --from=builder /app/build/web ./build/web

# Expose port
EXPOSE 8080

# Start server
CMD ["http-server", "./build/web", "-p", "8080", "--cors", "-o", "false"]
