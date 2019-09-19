import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_part/channel.dart';
import 'package:flutter_part/page_a.dart';
import 'package:flutter_part/page_b.dart';

void main() => runApp(MyApp(window.defaultRouteName));

class MyApp extends StatefulWidget {
  final String defaultRouteName;

  const MyApp(this.defaultRouteName, {Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    print('>>>>>>>>>>>>>>>> ${widget.defaultRouteName}');
    Widget targetPage = MyHomePage();
    switch (widget.defaultRouteName) {
      case 'pageA':
        targetPage = PageA();
        break;
      case 'pageB':
        targetPage = PageB();
        break;
      default:
        targetPage = Scaffold(
            appBar: AppBar(
              title: Text('无效的页面'),
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
            body: Container(child: Center(child: Text('无效的页面'))));
    }
    return MaterialApp(
      routes: {
        'home': (ctx) => MyHomePage(),
        'pageA': (ctx) => PageA(),
        'pageB': (ctx) => PageB(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: targetPage,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Text('data'),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.backspace,
            color: Colors.white,
          ),
          onPressed: () {
            print('>>>>>>>>>>>>');
            if (Navigator.canPop(context) == true) {
              Navigator.pop(context);
            } else {
              _incrementCounter();
              // FlutterPluginWorkTool.hybridNavBack();
            }
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'pageA');
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
