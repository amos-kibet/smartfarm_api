## Notes

- Replace MQTT with WebSocket for data transfer between hardware and the backend.
- Currently, the hardware transfers data to a separate software via MQTT, then the backend retrieves the data from the software, again using MQTT.

## Details

- Implement WebSocket logic on the backend, that will receive data from the hardware - not ideal; it introduces an overhead on the hardware developer to learn/implement WebSocket.
- Or, maybe have the hardware save data directly to a central database, where the backend can then fetch data from.
- Or better yet, let the hardware transfer data to the backend using HTTP protocol - why are we even moving away from MQTT, the best protocol for IoT?

## Discussion

- MQTT is the most-suited protocol for real-time data transfer use-cases, like IoT. What's the point of moving away from it to HTTP?
- The MQTT broker will act like a database, except it's not; it does not persist data, it just transfers it to subscribers. The developer will have to store the data in a database.
- Maybe it makes sense to replace MQTT with a mix of HTTP and WebSocket then. It will save the overhead of worrying about an external application that handles a crucial part of the data transfer pipeline.
- With HTTP + WebSocket, the client will always get real-time data, the moment it is saved in the database, achieving two things; persisting data and streaming it real-time to the clients.

## Conclusion

- Hardware transmits data to the backend via HTTP.
- The backend then persists the data in the DB.
- As soon as there is new data in the DB, it is transmitted to the clients using WebSocket.
- Benefits:
  - Less moving parts.
  - Reduced complexity.
  - Eliminated dependency on external software, that we have no control over.
