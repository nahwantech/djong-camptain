#!/bin/sh

/bin/ollama serve &  # Start Ollama server in the background
pid=$!  # Capture process ID

echo "🚀 Ollama is running..."

echo "📥 Downloading deepseek-r1:1.5b model..."

ollama pull deepseek-r1:1.5b

echo "✅ deepseek-r1:1.5b model downloaded successfully!"

ollama run deepseek-r1:1.5b

echo "🚀 deepseek-r1:1.5b model running!"

wait $pid  # Keep the script running