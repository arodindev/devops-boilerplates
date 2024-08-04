# Benutze python base image
FROM python:3.12.4-slim

# Setze workdir
WORKDIR /app

# Kopiere alles zum Image (auser files und folder aus .dockerignore)
COPY . .

# Installiere pip dependencies
RUN pip install -r  requirements.txt

# Starte uvicorn (für FastAPI) server auf localhost:8000
CMD ["uvicorn", "main:app", "--reload", "--host", "0.0.0.0", "--port", "8000"]