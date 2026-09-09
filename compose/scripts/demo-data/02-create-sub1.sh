#!/usr/bin/env bash

echo "Creating Subscription: 1CreateTPfromTR..."

STATUS=$(curl \
    -s \
    -o /dev/null \
    -w "%{http_code}" \
    -X POST "http://localhost:8080/ngsi-ld/v1/subscriptions" \
    -H "Link: <${NEMOBIL_NGSI_JSON_LD_CONTEXT}>; rel=\"http://www.w3.org/ns/json-ld#context\"; type=\"application/ld+json\"" \
    -H "NGSILD-Tenant: ${APPLICATION_TENANTS_0_NAME}" \
    -H "Authorization: Bearer ${ACCESS_TOKEN}" \
    -H "Content-Type: application/json" \
    -d $'{
  "id": "urn:ngsi-ld:Subscription:1CreateTPfromTR",
  "type": "Subscription",
  "description": "Subscription to feed createTPfromTR",
  "entities": [
    {
      "type": "TripRequest"
    }
  ],
  "notificationTrigger": [
    "entityCreated"
  ],
  "notification": {
    "format": "keyValues",
    "endpoint": {
      "uri": "http://nemobil-apisix:9080/nodered/createTPfromTR",
      "accept": "application/json"
      
    }
  }
}')

if [ "$HTTP_CODE" -eq 201 ]; then
    echo "✓ Subscription created (HTTP $HTTP_CODE)"
    exit 0
else
    echo "✗ Failed to create subscription (HTTP $HTTP_CODE)"
    exit 1
fi