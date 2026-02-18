#!/usr/bin/with-contenv bashio

NETWORK=$(bashio::config 'network')
ACCESS_TOKEN=$(bashio::config 'access_token')
REFRESH_TOKEN=$(bashio::config 'refresh_token')
LOG_LEVEL=$(bashio::config 'log_level')

if [ -z "$NETWORK" ] || [ -z "$ACCESS_TOKEN" ] || [ -z "$REFRESH_TOKEN" ]; then
  bashio::log.error "Missing required configuration."
  exit 1
fi

export TWINGATE_NETWORK="$NETWORK"
export TWINGATE_ACCESS_TOKEN="$ACCESS_TOKEN"
export TWINGATE_REFRESH_TOKEN="$REFRESH_TOKEN"
export TWINGATE_LOG_LEVEL="$LOG_LEVEL"

mkdir -p /data

status_loop() {
  while true; do
    echo "{
      \"status\": \"connected\",
      \"version\": \"unknown\",
      \"last_heartbeat\": \"$(date -Iseconds)\",
      \"uptime_seconds\": $(cut -d. -f1 /proc/uptime),
      \"resources\": 0
    }" > /data/status.json
    sleep 30
  done
}

status_loop &

python3 -m http.server 8099 --directory /data &

exec /usr/bin/twingate-connector
