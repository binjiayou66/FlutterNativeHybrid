import 'package:flutter/material.dart';
import 'package:flutter_part/channel.dart';

class PageB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page B'),
        leading: IconButton(
          icon: Icon(
            Icons.backspace,
            color: Colors.white,
          ),
          onPressed: () {
            if (Navigator.canPop(context) == true) {
              Navigator.pop(context);
            } else {
              PlatformChannel.platformNavBack(context);
            }
          },
        ),
      ),
      body: Center(
        child: Text('Page B'),
      ),
    );
  }
}
