# Dockerfile

# Use an official PyTorch image as a base
FROM pytorch/pytorch:2.3.0-cuda12.1-cudnn8-runtime

# Install Poetry using pip (more reliable in Docker)
RUN pip install poetry==1.8.2

# Configure Poetry
ENV POETRY_VIRTUALENVS_IN_PROJECT=true
ENV POETRY_NO_INTERACTION=1

# Set the working directory in the container
WORKDIR /app

# Copy the project dependency files first for caching
COPY pyproject.toml poetry.lock* ./


RUN poetry install --no-root

# Copy the rest of the application's source code
COPY . .

# Default command to run when the container starts
CMD ["poetry", "run", "python", "main.py"]