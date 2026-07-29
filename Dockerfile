# Stage 1: Build the Vite frontend
FROM node:20-slim AS frontend-builder

WORKDIR /app/frontend

# Copy package files and install dependencies
COPY frontend/package*.json ./
RUN npm install

# Copy frontend source and build
COPY frontend/ ./
RUN npm run build

# Stage 2: Build the backend and serve the application
FROM python:3.11-slim

WORKDIR /app

# Copy and install python requirements
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the frontend build output
# Odin.py resolves FRONTEND to the 'frontend' directory relative to the project root
COPY --from=frontend-builder /app/frontend/dist ./frontend/dist

# Copy the backend source
COPY backend/ ./backend/

WORKDIR /app/backend

# Set python path
ENV PYTHONPATH=/app/backend

# Expose the port Odin.py will run on
EXPOSE 8000

# Start the server with host binding to 0.0.0.0
CMD ["python", "Odin.py", "--host", "0.0.0.0", "--port", "8000"]
