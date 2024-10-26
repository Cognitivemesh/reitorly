FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Set up working directory
WORKDIR /app

# Copy pyproject.toml
COPY pyproject.toml .

# Install dependencies using uv
RUN uv pip install -r pyproject.toml

# Copy the rest of the application
COPY . .

# Expose port for Marimo
EXPOSE 8000

# Command to run Marimo
CMD ["marimo", "serve", "--host", "0.0.0.0", "--port", "8000"]
