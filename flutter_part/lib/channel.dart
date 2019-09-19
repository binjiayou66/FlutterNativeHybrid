import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlatformChannel {
  static const channel = const MethodChannel('com.andy.666');

  static Future<String> getToken() async {
    return await channel.invokeMethod('getToken');
  }

  static Future<void> showLogin() async {
    await channel.invokeMethod('showLogin');
  }

  static Future<dynamic> getConfig() async {
    return await channel.invokeMethod('getConfig');
  }

  static Future<dynamic> platformNavBack(BuildContext context) async {
    if (Navigator.canPop(context) == true) {
      Navigator.pop(context);
      return Future.value();
    }
    return await channel.invokeMethod('platformNavBack');
  }
}
