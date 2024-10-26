# syntax=docker/dockerfile:1.4
# ================================
# Build Stage
# ================================
FROM python:3.11-slim AS builder

# Arguments for versions
ARG DUCKDB_VERSION=0.10.2

# Install build dependencies and tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Set environment variables for pip and uv
ENV PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONUSERBASE=/opt/venv

ENV PATH="/root/.cargo/bin:/opt/venv/bin:${PATH}"

# Set working directory
WORKDIR /app

# Copy pyproject.toml
# Copy only dependency files first for better caching
COPY pyproject.toml poetry.lock* ./

# Install dependencies using uv
RUN uv install --upgrade pip setuptools wheel \
    && uv install --system --no-cache-dir -e . \
    && uv install --system -r pyproject.toml

# ================================
# Runtime Stage
# ================================
FROM python:3.10-slim

# Create a non-root user with a fixed UID for consistency
RUN useradd --create-home --uid 1000 appuser

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PATH="/opt/venv/bin:${PATH}"

# Create a virtual environment directory
ENV PYTHONUSERBASE=/opt/venv

# Install runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libduckdb-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy installed packages from the builder stage
COPY --from=builder /opt/venv /opt/venv
COPY --from=builder /usr/local /usr/local

# Set working directory
WORKDIR /app

# Copy application code with appropriate ownership
COPY --chown=appuser:appuser . .

# Set ownership for data directory if needed
# RUN chown -R appuser:appuser /app/data

# Switch to non-root user
USER appuser

# Copy the rest of the application
COPY . .

# Expose port for Marimo
EXPOSE 3000

# Healthcheck command
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
  CMD python -c "import gorilla_cli; import duckdb" || exit 1

# Command to run Marimo
# Define the default command
CMD ["marimo", "serve", "--host", "0.0.0.0", "--port", "3000"]
