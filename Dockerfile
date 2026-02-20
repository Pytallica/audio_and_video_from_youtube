FROM python:3.12-slim

WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends ffmpeg && \
    rm -rf /var/lib/apt/lists/*

COPY pyproject.toml .
RUN pip install --no-cache-dir setuptools wheel && \
    pip install --no-cache-dir --timeout=300 .

RUN useradd -u 10001 -m appuser

COPY . .
RUN chown -R appuser:appuser /app

USER appuser

CMD ["python", "main.py"]