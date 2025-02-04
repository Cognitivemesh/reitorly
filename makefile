# Define variables
OS := $(shell uname -s)
PYTHON           := python # It runs python default
PY_VERSION		 := 3.11
VENV             := .venv
HTTP_PORT := 3500
DOCKER_INSTALLED := $(shell command -v docker >/dev/null 2>&1 && echo yes || echo no)
DOCKER_IMAGE     := reitorly:latest
DOCKER_CONTAINER := reitorly

# Default target
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  setup                Create virtual environment and install dependencies (using uv)"
	@echo "  run                  Run the application (app/app.py)"
	@echo "  test                 Run tests using pytest"
	@echo "  lint                 Lint the code using flake8"
	@echo "  uv-install         Run uv package manager install commands"
	@echo "  docker-build         Build Docker image"
	@echo "  docker-run           Run Docker container"
	@echo "  docker-clean         Stop and remove Docker container"
	@echo "  compose-up           Start services with docker-compose"
	@echo "  compose-down         Stop services with docker-compose"
	@echo "  clean                Remove virtual environment and __pycache__ directories"

# Setup virtual environment and install dependencies using uv
.PHONY: setup
setup:
	@echo "Creating virtual environment using uv..."
	uv venv $(VENV) --python $(PY_VERSION) --verbose 2>&1 | tee uv-venv.log
	@echo "Installing project dependencies with uv..."
	uv pip install --editable . --verbose --upgrade
	@echo "Activate virtual environment"
	source $(VENV)/bin/activate

# Optional target to run uv install commands (if you prefer to use uv directly)
.PHONY: uv-install
uv-install:
	@echo "Synchronizing project dependencies with uv..."
	source $(VENV)/bin/activate
	uv sync

# Run the sample-dashboard
.PHONY: run-dashboard
run-dashboard:
	@echo "Running application..."
	$(VENV)/bin/python src/app/dashboard.py
#	$(VENV)/bin/python src/app/app.py

# Run the application
.PHONY: run-app
run-app:
	@echo "Running application..."
	$(VENV)/bin/python src/app/app.py

# Run tests using pytest
.PHONY: test
test:
	@echo "Running tests..."
	$(VENV)/bin/pytest

# Lint the code using flake8
.PHONY: lint
lint:
	@echo "Linting code..."
	$(VENV)/bin/flake8 app/

# Docker targets
# Check that Docker is installed and the daemon is running.
# This target verifies:
#   1. The Docker command is available.
#   2. docker info can connect to the Docker daemon.
.PHONY: check-docker
check-docker:
	@echo "Checking Docker installation..."
	@if ! command -v docker > /dev/null 2>&1; then \
	    echo "Error: Docker command not found. Please install Docker."; \
	    exit 1; \
	fi
	@if ! docker info > /dev/null 2>&1; then \
	    echo "Error: Cannot connect to the Docker daemon at unix:///var/run/docker.sock."; \
	    echo "       Is the Docker daemon running? Also, check if the docker command is configured correctly (e.g. invoking podman without it being installed)."; \
	    exit 1; \
	fi

# Target to check and install Docker if not present
.PHONY: check-and-install-docker
check-and-install-docker:
ifeq ($(DOCKER_INSTALLED),no)
	@echo "Docker is not installed. Proceeding with installation..."
	@if [ "$(OS)" = "Linux" ]; then \
		# Update package list and install prerequisites
		sudo apt-get update && \
		sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common && \
		# Add Docker's official GPG key
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
		# Add Docker repository
		sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(shell lsb_release -cs) stable" && \
		# Update package list again
		sudo apt-get update && \
		# Install Docker
		sudo apt-get install -y docker-ce && \
		# Start and enable Docker service
		sudo systemctl start docker && \
		sudo systemctl enable docker && \
		# Add current user to Docker group
		sudo usermod -aG docker $(USER) && \
		echo "Docker installation completed successfully."; \
	else \
		echo "Unsupported operating system: $(OS). Please install Docker manually."; \
		exit 1; \
	fi
else
	@echo "Docker is already installed."
endif

# Check if Docker Compose is available
.PHONY: check-docker-compose
check-docker-compose:
	@echo "Checking if Docker Compose is available..."
	@command -v docker-compose > /dev/null 2>&1 || { \
		echo "Error: Docker Compose not found. Please ensure Docker Compose is installed and the 'docker-compose' command is in your PATH."; \
		exit 1; \
	}

# Build Docker image
.PHONY: docker-build
docker-build: check-docker
	@echo "Building Docker image..."
	docker build --no-cache --progress=plain -t $(DOCKER_IMAGE) .

# Run Docker container
.PHONY: docker-debug
docker-debug: check-docker
	@echo "Running Docker container $(DOCKER_CONTAINER)..."
#	@docker run -d --name $(DOCKER_CONTAINER) -p $(HTTP_PORT):$(HTTP_PORT) $(DOCKER_IMAGE)
	@docker run -it --rm --name $(DOCKER_CONTAINER) --entrypoint=/bin/sh $(DOCKER_IMAGE)

# Run Docker container
.PHONY: docker-run
docker-run: check-docker
	@echo "Running Docker container $(DOCKER_CONTAINER)..."
	@docker run -d --name $(DOCKER_CONTAINER) -p $(HTTP_PORT):$(HTTP_PORT) $(DOCKER_IMAGE)
	

# List currently running Docker containers
.PHONY: docker-ps
docker-ps:
	@echo "Listing currently running Docker containers..."
	@docker ps

# List all Docker images
.PHONY: docker-images
docker-images:
	@echo "Listing all Docker images..."
	@docker images

# Stop and remove all Docker containers
.PHONY: docker-clean-containers
docker-clean-containers:
	@echo "Stopping all running Docker containers..."
	@containers=$$(docker ps -q); \
	if [ -n "$$containers" ]; then \
	    docker stop $$containers; \
	else \
	    echo "No running containers to stop."; \
	fi
	@echo "Removing all Docker containers..."
	@all_containers=$$(docker ps -a -q); \
	if [ -n "$$all_containers" ]; then \
	    docker rm $$all_containers; \
	else \
	    echo "No containers to remove."; \
	fi

# Remove all Docker images
.PHONY: docker-clean-images
docker-clean-images:
	@echo "Removing all Docker images..."
	@docker rmi $$(docker images -q)

# Stop and remove Docker container
.PHONY: docker-clean-container
docker-clean-container: check-docker
	@echo "Stopping and removing Docker container $(DOCKER_CONTAINER)..."
	-docker stop $(DOCKER_CONTAINER) || true
	-docker rm $(DOCKER_CONTAINER) || true

# Run Docker Compose
.PHONY: docker-compose-up
docker-compose-up: check-docker-compose check-docker
	@echo "Starting services with Docker Compose..."
	docker-compose up -d

# Run Docker Compose down
.PHONY: docker-compose-down
docker-compose-down: check-docker-compose check-docker
	@echo "Stopping services with docker-compose..."
	docker-compose down

# Clean up virtual environment and __pycache__
.PHONY: clean
clean:
	@echo "Cleaning up: removing virtual environment and __pycache__ directories..."
	rm -rf $(VENV)
	find . -type d -name "__pycache__" -exec rm -rf {} +

.PHONY: clean-wsl
clean-wsl:
	@echo "Disk usage before cleanup:"
	@df -h /
	@echo "Starting cleanup process..."

	# Remove unused packages and clean up APT cache
	@sudo apt-get autoremove -y
	@sudo apt-get autoclean -y
	@sudo apt-get clean -y

	# Remove temporary files
	@sudo rm -rf /tmp/*
	@sudo rm -rf /var/tmp/*

	# Clean Docker system if Docker is installed
	@if command -v docker >/dev/null 2>&1; then \
		echo "Cleaning Docker system..."; \
		docker system prune -a --volumes -f; \
	else \
		echo "Docker is not installed; skipping Docker cleanup."; \
	fi

	@echo "Cleanup process completed."
	@echo "Disk usage after cleanup:"
	@df -h /