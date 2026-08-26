#!/usr/bin/env bash

echo "Creating Subscription: 3mocktripsplanned..."

STATUS=$(curl \
    -s \
    -o /dev/null \
    -w "%{http_code}" \
    -X POST "http://localhost:8080/ngsi-ld/v1/subscriptions" \
    -H "Link: <${NEMOBIL_NGSI_JSON_LD_CONTEXT}>; rel=\"http://www.w3.org/ns/json-ld#context\"; type=\"application/ld+json\"" \
    -H 'NGSILD-Tenant: ${APPLICATION_TENANTS_0_NAME}' \
    -H "Authorization: Bearer ${ACCESS_TOKEN}" \
    -H 'Content-Type: application/json' \
    -d $'{
  "id": "urn:ngsi-ld:Subscription:3mocktripsplanned",
  "type": "Subscription",
  "description": "Subscription to feed mocktripsplanned",
  "entities": [
    {
      "type": "Trip"
    }
  ],
  "notificationTrigger": [
    "entityCreated"
  ],
  "q": "status==%22Unplanned%22",
  "notification": {
    "attributes": [
      "user"
    ],
    "format": "keyValues",
    "endpoint": {
      "uri": "http://nemobil-apisix:9080/nodered/mocktripsplanned",
      "accept": "application/json"
    }
  }
}')

case "$STATUS" in
    201)
        echo "✓ Subscription created (HTTP $STATUS)"
        ;;
    409)
        echo "✓ Subscription already exists (HTTP $STATUS)"
        ;;
    *)
        echo "✗ Failed to create subscription (HTTP $STATUS)"
        ;;
esac