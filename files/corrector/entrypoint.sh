#!/bin/bash

cp /tmp/templates/settings.yaml /etc/xroad-metrics/corrector/settings.yaml
sed -i "s|PASSWORD_PLACEHOLDER|$CORRECTOR_PASSWORD|g" /etc/xroad-metrics/corrector/settings.yaml

# Start your application
exec "$@"
