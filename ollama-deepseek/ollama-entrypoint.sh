#!/bin/sh
# clear ready flag
rm -f /tmp/ready

ollama serve &

echo "Starting Ollama..."
until curl -s http://localhost:11434 > /dev/null; do
  sleep 1
done

MODELS="codellama:7b deepseek-coder:6.7b"

for MODEL in $MODELS; do
  if ! ollama list | grep -q "$MODEL"; then
    echo "⚡️ Pulling model: $MODEL"
    ollama pull "$MODEL"
  else
    echo "⛳️ Model '$MODEL' already present."
  fi
done

touch /tmp/ready

nginx -g "daemon off;"
