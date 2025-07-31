FROM pytorch/pytorch:2.3.0-cuda12.1-cudnn8-runtime
RUN pip install poetry==1.8.2
ENV POETRY_VIRTUALENVS_IN_PROJECT=true
ENV POETRY_NO_INTERACTION=1
WORKDIR /app
COPY pyproject.toml poetry.lock* ./
RUN poetry install --no-root
COPY . .
CMD ["poetry", "run", "python", "main.py"]