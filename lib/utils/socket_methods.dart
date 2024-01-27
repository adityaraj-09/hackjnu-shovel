

import 'package:flutter/cupertino.dart';
import 'package:hackjnu_dumper/map_provider.dart';
import 'package:hackjnu_dumper/utils/socket_client.dart';
import 'package:provider/provider.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;
  sendData(double longitude, double latitude, String userId, bool reached,
      double d, double t) {
    _socketClient.emit("location", {
      "longitude": longitude,
      "latitude": latitude,
      "userId": userId,
      "reached": reached,
      "dist": d,
      "time": t
    });
  }

  sendLoadingData(double per) {
    _socketClient.emit("loading", {"filled": per});
  }
  //  receiveLocation(BuildContext context) {
  //   _socketClient.on("location_web", (data) {
  //     print(data);
  //     Provider.of<MapProvider>(context, listen: false).setData(data);
  //   });
  // }

  receiveLoadingData(BuildContext context) {
    _socketClient.on("fromhardware", (data) {
      Provider.of<MapProvider>(context, listen: false)
          .setfilled(data["filled"]);
    });
  }
}
