# Project Build and Management Guide

This guide provides instructions on how to use the `Makefile` to manage various aspects of the project, including environment setup, running the application, testing, linting, and Docker operations.

## Prerequisites

- **Python 3.11**: Ensure that Python 3.11 is installed on your system. You can download it from the [official Python website](https://www.python.org/downloads/).

- **Docker**: Install Docker to build and run containerized applications. Follow the installation guide on the [Docker website](https://docs.docker.com/get-docker/).

- **GNU Make**: Make sure GNU Make is installed on your system. It's typically pre-installed on Unix-based systems. For Windows, consider using [Make for Windows](http://gnuwin32.sourceforge.net/packages/make.htm) or the Windows Subsystem for Linux (WSL).

## Makefile Targets

The `Makefile` includes several targets to streamline development tasks. Below is a list of available targets and their descriptions:

- **help**: Display a list of available targets.
- **setup**: Create a virtual environment and install dependencies using `uv`.
- **run**: Execute the application located at `app/app.py`.
- **test**: Run tests using `pytest`.
- **lint**: Lint the code using `flake8`.
- **uv-install**: Install dependencies using the `uv` package manager.
- **docker-build**: Build the Docker image.
- **docker-run**: Run the Docker container.
- **docker-clean**: Stop and remove the Docker container.
- **compose-up**: Start services with `docker-compose`.
- **compose-down**: Stop services with `docker-compose`.
- **clean**: Remove the virtual environment and `__pycache__` directories.

## Usage

To execute a target, use the `make` command followed by the target name. 
Before running the application, set up the virtual environment and install the necessary dependencies.For example:

```bash
make setup
```

### 1. Setting Up the Environment

Before running the application, set up the virtual environment and install the necessary dependencies.

```bash
make setup
```

This command will:

- Create a virtual environment in the directory specified by the `VENV` variable (default is `venv`).
- Upgrade `pip` to the latest version.
- Install project dependencies using `pip`.

**Note**: The `setup` target uses `pip` for installing dependencies. If you prefer to use the `uv` package manager, you can run:

```bash
make uv-install
```

This will:

- Upgrade `pip`, `setuptools`, and `wheel`.
- Install dependencies specified in `pyproject.toml` using `uv`.

### 2. Running the Application

To run the application located at `app/app.py`:

```bash
make run
```

Ensure that the virtual environment is activated, and all dependencies are installed before running the application.

### 3. Running Tests

To execute tests using `pytest`:

```bash
make test
```

This will run all tests in the project. Ensure that test files are named appropriately (e.g., `test_*.py`) and are located in the designated test directories.

### 4. Linting the Code

To lint the code using `flake8`:

```bash
make lint
```

This will check the code in the `app/` directory for style violations and potential errors. Ensure that `flake8` is included in your project's dependencies.

### 5. Docker Operations

**Building the Docker Image**:

```bash
make docker-build
```

This command builds the Docker image using the `Dockerfile` in the project root. The image will be tagged as specified by the `DOCKER_IMAGE` variable (default is `reitorly:latest`).

**Running the Docker Container**:

```bash
make docker-run
```

This runs the Docker container based on the previously built image. The container will be named as specified by the `DOCKER_CONTAINER` variable (default is `reitorly`) and will map port 3000 of the container to port 3000 on the host.

**Stopping and Removing the Docker Container**:

```bash
make docker-clean
```

This stops and removes the running Docker container.

### 6. Docker Compose Operations

If you're using `docker-compose` to manage multi-container applications:

**Starting Services**:

```bash
make compose-up
```

This starts all services defined in the `docker-compose.yml` file in detached mode.

**Stopping Services**:

```bash
make compose-down
```

This stops all running services and removes containers, networks, and volumes defined in the `docker-compose.yml` file.

### 7. Cleaning Up

To remove the virtual environment and `__pycache__` directories:

```bash
make clean
```

This is useful for resetting the environment or preparing the project for a fresh setup.

## Customizing the Makefile

The `Makefile` uses variables to define commands and settings, allowing for easy customization:

- `PYTHON`: Specifies the Python interpreter to use (default is `python3.11`).
- `VENV`: Defines the directory for the virtual environment (default is `venv`).
- `DOCKER_IMAGE`: Sets the name and tag for the Docker image (default is `reitorly:latest`).
- `DOCKER_CONTAINER`: Names the Docker container (default is `reitorly`).

To override these variables, you can pass them as arguments to the `make` command:

```bash
make VENV=myenv setup
```

This command will create the virtual environment in a directory named `myenv`.

## Conclusion

This `Makefile` provides a streamlined approach to managing various aspects of the project, from environment setup to deployment. By utilizing these targets, you can ensure a consistent and efficient workflow.

For more information on using `Makefile` with Python projects, consider reading [Creating a Python Makefile](https://earthly.dev/blog/python-makefile/).

**Note**: Always ensure that the paths and commands in the `Makefile` are tailored to your project's structure and requirements.
```