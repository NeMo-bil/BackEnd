#!/usr/bin/env bash

echo "Creating Subscription: CreateTPfromTR..."

STATUS=$(curl \
    -s \
    -o /dev/null \
    -w "%{http_code}" \
    -X POST "http://localhost:8080/ngsi-ld/v1/subscriptions" \
    -H 'Link: <https://api.npoint.io/d66beea7313de1ad894c>; rel="http://www.w3.org/ns/json-ld#context"; type="application/ld+json"' \
    -H 'NGSILD-Tenant: urn:ngsi-ld:tenant:default' \
    -H "Authorization: Bearer ${ACCESS_TOKEN}" \
    -H 'Content-Type: application/json' \
    -d $'{
  "notificationTrigger": [
    "entityCreated"
  ],
  "id": "urn:ngsi-ld:Subscription:1CreateTPfromTR2",
  "notification": {
    "format": "keyValues",
    "endpoint": {
      "uri": "http://nemobil-apisix:9080/nodered/createTPfromTR",
      "accept": "application/json"
    }
  },
  "entities": [
    {
      "type": "TripRequest"
    }
  ],
  "type": "Subscription",
  "description": "Subscription to feed createTPfromTR",
  "isActive": true
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