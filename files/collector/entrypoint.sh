#!/bin/bash

cp /tmp/templates/settings.yaml /etc/xroad-metrics/collector/settings.yaml
sed -i "s|PASSWORD_PLACEHOLDER|$COLLECTOR_PASSWORD|g" /etc/xroad-metrics/collector/settings.yaml

# Start your application
exec "$@"
