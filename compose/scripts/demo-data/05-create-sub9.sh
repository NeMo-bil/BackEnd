#!/usr/bin/env bash

echo "Creating Subscription: 9mockmove..."

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
  "id": "urn:ngsi-ld:Subscription:9mockmove",
  "type": "Subscription",
  "description": "Subscription to feed mockmove",
  "entities": [
    {
      "type": "Cab"
    }
  ],
  "watchedAttributes": [
    "state"
  ],
  "notificationTrigger": [
    "attributeUpdated"
  ],
  "q": "state==%22Approaching%22,%22RidingToKonvoi%22,%22RidingInKonvoi%22,%22Riding%22;stateADStack==%22OnRoute%22",
  "notification": {
    "attributes": [
      "location",
      "nextStopLocation",
      "nextStopArrival",
      "state",
      "stateADStack",
      "dropoffLocation",
      "dropoffTime"      
    ],
    "format": "keyValues",
    "endpoint": {
      "uri": "http://nemobil-apisix:9080/nodered/mockmove",
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