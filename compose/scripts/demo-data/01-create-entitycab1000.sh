#!/usr/bin/env bash

echo "Creating Entity: urn:ngsi-ld:Cab:1000..."

STATUS=$(curl \
    -s \
    -o /dev/null \
    -w "%{http_code}" \
    -X POST "http://localhost:8080/ngsi-ld/v1/entities" \
    -H "Link: <${NEMOBIL_NGSI_JSON_LD_CONTEXT}>; rel=\"http://www.w3.org/ns/json-ld#context\"; type=\"application/ld+json\"" \
    -H "NGSILD-Tenant: ${APPLICATION_TENANTS_0_NAME}" \
    -H "Authorization: Bearer ${ACCESS_TOKEN}" \
    -H "Content-Type: application/json" \
    -d $'{
  "id": "urn:ngsi-ld:Cab:1000",
  "type": "Cab",
  "stateOfSchedule": {
    "type": "Property",
    "value": "Active"
  },
  "state": {
    "type": "Property",
    "value": "Idle"
  },
  "stateADStack": {
    "type": "Property",
    "value": "Idle"
  },
  "stateCoupling": {
    "type": "Property",
    "value": "Free"
  },
  "doorLock": {
    "type": "Property",
    "value": "Locked"
  },
  "passengerInformation": {
    "type": "Property",
    "value": ""
  },
  "seats": {
    "type": "Property",
    "value": 2
  },
  "childSeats": {
    "type": "Property",
    "value": 0
  },
  "luggage": {
    "type": "Property",
    "value": 2
  },
  "location": {
    "type": "GeoProperty",
    "value": {
      "type": "Point",
      "coordinates": [
			51.7223422,
      		8.7868980
      ]
    }
  },
  "nextStopLocation": {
    "type": "GeoProperty",
    "value": {
      "type": "Point",
      "coordinates": [
        0,
        0
      ]
    }
  },
  "nextStopArrival": {
    "type": "Property",
    "value": ""
  },
  "stopKey": {
    "type": "Property",
    "value": ""
  },
  "deviation": {
    "type": "Property",
    "value": 0.0
  },
  "toBeChainedVehicles": {
    "type": "Property",
    "value": []
  },
  "chainedPosition": {
    "type": "Property",
    "value": 0
  },
  "chainedVehicles": {
    "type": "Property",
    "value": 0
  },
  "features": [
    {
      "type": "Property",
      "value": {
        "id": "urn:ngsi-ld:Skill:WheelChair",
        "name": "WheelChair"
      }
    }
  ],
  "licensePlate": {
    "type": "Property",
    "value": "PB CAB 1000"
  },
  "shortId": {
    "type": "Property",
    "value": 1000
  },
  "vehicleScheduleGuid": {
    "type": "Relationship",
    "object": "urn:ngsi-ld:Schedule:66557"
  },
  "bearing": {
    "type": "Property",
    "value": 0.0
  },
  "speed": {
    "type": "Property",
    "value": 0.0
  },
  "batteryPower": {
    "type": "Property",
    "value": 11000.0
  },
  "batteryCurrent": {
    "type": "Property",
    "value": 11000.0
  },
  "batteryLevel": {
    "type": "Property",
    "value": 50.0
  }
}')

if [ "$HTTP_CODE" -eq 201 ]; then
    echo "✓ Cab Entity created (HTTP $HTTP_CODE)"
    exit 0
else
    echo "✗ Failed to create Cab Entity (HTTP $HTTP_CODE)"
    exit 1
fi