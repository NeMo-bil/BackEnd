#!/usr/bin/env bash

echo "Creating Subscription: 2btripidtocab..."

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
  "id": "urn:ngsi-ld:Subscription:2btripidtocab",
  "type": "Subscription",
  "description": "Subscription to copy the trip_id to the cab for final trip performed booking",
  "entities": [
    {
      "type": "Trip"
    }
  ],
  "watchedAttributes": [
    "vehicle"
  ],
  "notificationTrigger": [
    "attributeUpdated"
  ],
  "q": "vehicle!=%22%22", 
  "notification": {
    "attributes": [
      "user",
      "vehicle",
      "pickupLocation",
      "pickupTime",
      "dropoffLocation",
      "targetTime"
    ],
    "format": "keyValues",
    "endpoint": {
      "uri": "http://nemobil-apisix:9080/nodered/tripidtocab",
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