## Backend API endpoints

### For Gloria

**WebSocket Connection Url**

```cURL
wss://smartfarm-api.fly.dev/socket/websocket
```

**Data Structure:**

You will get data that looks like this:

```JSON
{"telemetry":
    {
        "air_temperature": 25,
        "soil_temperature": 25,
        "humidity": 25,
        "rainfall_intensity": 25,
        "sunlight_intensity": 25,
        "soil_ph": 25,
        "timestamp": "25"
    }
}
```

You will have to `console.log()` to know whether the WebSocket connection was successful or not, and to see the data streaming in.

### For Elijah

**HTTP POST Url**

```cURL
https://smartfarm-api.fly.dev/api/v1/telemetry
```

**Data Structure:**

You will have to post data that looks like this:

```JSON
{"telemetry":
    {
        "air_temperature": 25,
        "soil_temperature": 25,
        "humidity": 25,
        "rainfall_intensity": 25,
        "sunlight_intensity": 25,
        "soil_ph": 25,
        "timestamp": "25"
    }
}
```

If successfull, you will get an API response like this:

```JSON
{
    "status": "success",
    "message": "Telemetry received successfully!"
}
```

If unsuccessful, you will get an API response like this:

```JSON
{
    "status": "error",
    "message": "Invalid data format!"
}
```
