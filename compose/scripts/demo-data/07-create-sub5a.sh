#!/usr/bin/env bash

echo "Creating Subscription: 5atripperformed..."

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
  "id": "urn:ngsi-ld:Subscription:5atripperformed",
  "type": "Subscription",
  "description": "Subscription to close the trip and the cab after performing the trip",
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
  "q": "state==%22OffBoardingFinished%22",
  "notification": {
    "attributes": [
      "state",
      "location",
      "nextStopArrival",
      "nextStopLocation",
      "stopKey",
      "deviation",
      "chainedVehicles",
      "chainedPosition",
      "toBeChainedVehicles",
      "stateCoupling",
      "lastBookingTrip_id",
      "stateADStack"
    ],
    "format": "keyValues",
    "endpoint": {
      "uri": "http://nemobil-apisix:9080/nodered/tripperformed",
      "accept": "application/json"
    }
  }
}')

if [ "$STATUS" -eq 201 ]; then
    echo "✓ Subscription created (HTTP $STATUS)"
    exit 0
else
    echo "✗ Failed to create subscription (HTTP $STATUS)"
    exit 1
fi