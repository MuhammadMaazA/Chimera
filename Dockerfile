FROM pytorch/pytorch:2.3.0-cuda12.1-cudnn8-runtime

# Set environment variables for better package management
ENV PYTHONUNBUFFERED=1
ENV PIP_NO_CACHE_DIR=1
ENV PIP_DISABLE_PIP_VERSION_CHECK=

WORKDIR /app

# Copy only pyproject.toml first to check dependencies
COPY pyproject.toml ./

# Install only the packages that aren't already in the base image
# Exclude torch, torchvision, and NVIDIA packages that are already installed
RUN pip install poetry==1.8.2 && \
    poetry export -f requirements.txt --output requirements.txt --without-hashes && \
    # Remove torch and nvidia packages from requirements as they're already installed
    sed -i '/^torch/d' requirements.txt && \
    sed -i '/^nvidia/d' requirements.txt && \
    sed -i '/^triton/d' requirements.txt && \
    # Install remaining packages
    pip install --no-deps -r requirements.txt && \
    # Clean up
    rm requirements.txt && \
    pip uninstall -y poetry

# Copy the rest of the application
COPY . .

CMD ["python", "main.py"]