# ./ollama-entrypoint.sh
# clear ready flag
rm -f /tmp/ready

ollama serve &

# start ollama, wait for it to serve
echo "Starting Ollama..."
until curl -s http://localhost:11434 > /dev/null; do
  sleep 1
done

# all the models to install
MODELS="codellama:7b deepseek-coder:6.7b"

# pull and install models, or skip if they're present
for MODEL in $MODELS; do
  if ! ollama list | grep -q "$MODEL"; then
    echo "⚡️ Pulling model: $MODEL"
    ollama pull "$MODEL"
  else
    echo "⛳️ Model '$MODEL' already present."
  fi
done

# set container as ready
touch /tmp/ready

# start nginx
nginx -g "daemon off;"