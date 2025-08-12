# Project Chimera: An Experimental Framework for Efficient Transformers

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python Version](https://img.shields.io/badge/python-3.12+-blue.svg)](https://www.python.org/downloads/)
[![Framework](https://img.shields.io/badge/Framework-PyTorch-orange.svg)](https://pytorch.org/)

This repository contains **Project Chimera**, a full-featured, research-grade framework for implementing, training, and benchmarking efficient Transformer architectures. It is designed to demonstrate a deep, practical understanding of modern ML engineering principles, from low-level model optimization to high-level experiment management and deployment.

The primary goal is to conduct a rigorous comparison of standard attention against state-of-the-art sparse and hardware-accelerated attention mechanisms on a real-world, long-text classification task.

-   **Author**: Muhammad Maaz
-   **GitHub**: [MuhammadMaazA](https://github.com/MuhammadMaazA)
-   **Contact**: <mmaaz172005@gmail.com>

---

## The Challenge: Scaling Transformers to Long Contexts

Standard Transformer models have a computational and memory complexity of O(n²), where 'n' is the sequence length. This quadratic scaling makes processing long documents, high-resolution images, or genomic data prohibitively expensive, creating a significant bottleneck for many real-world applications. Project Chimera tackles this problem head-on.

## How to Run This Framework

This project is fully containerized. The only prerequisites are **Docker**, **Docker Compose**, and a configured **NVIDIA GPU**.

#### 1. Build the Docker Container

This command reads the `Dockerfile`, installs all dependencies via Poetry, and prepares the environment. It only needs to be run once.

```bash
docker-compose build
```

#### 2. Run an Experiment

Use `docker-compose run` to execute an experiment. Hydra allows you to override any configuration parameter from the command line.

```bash
# Run the default experiment (standard_flash model)
docker-compose run --rm dev

# Run an experiment with the Longformer model configuration
docker-compose run --rm dev model=longformer

# Override multiple parameters: use Longformer with a different learning rate
docker-compose run --rm dev model=longformer training.learning_rate=5e-5
```

#### 3. View Results with MLflow

After running an experiment, launch the MLflow UI to analyze your results.

```bash
mlflow ui
```
Navigate to `http://localhost:5001` in your browser to see all logged parameters, metrics (like loss and accuracy), and saved model artifacts.

#### 4. Run the API Server (After Training)

Once a model is trained and saved via MLflow, you can serve it using the FastAPI application.

```bash
docker-compose run --rm dev poetry run python src/api/serve.py --run_id <YOUR_MLFLOW_RUN_ID>
```

---

## Project Structure

```
Project-Chimera/
├── configs/                # Hydra configuration files
│   ├── dataset/
│   ├── model/
│   └── training/
├── data/                   # (Will be created) Cached dataset files
├── mlruns/                 # (Will be created) MLflow experiment tracking data
├── src/                    # Main source code
│   ├── api/                # FastAPI server code
│   ├── data_pipeline/      # Data loading and processing
│   ├── models/             # Transformer and attention implementations
│   ├── training_engine/    # Training and evaluation loops
│   └── utils/              # Utility functions
├── .gitignore
├── docker-compose.yml
├── Dockerfile
├── main.py                 # Main entry point for experiments
├── poetry.lock             # Exact dependency versions
├── pyproject.toml          # Project dependencies (Poetry)
└── README.md
```
