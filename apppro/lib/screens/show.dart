import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_web/flutter_native_web.dart';
//import 'package:flutter_native_web/flutterwebview.dart';

class Show extends StatefulWidget {
  @override
  _ShowState createState() => _ShowState();
}

class _ShowState extends State<Show> {
  int _currentIndes = 0;
  final formkey = GlobalKey<FormState>();
  String soil =
      'https://thingspeak.com/channels/1082376/charts/1?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line';
  String water =
      'https://thingspeak.com/channels/1082376/charts/3?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line';
  String fil =
      'https://thingspeak.com/channels/1082376/charts/2?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15';
  WebController webController;

  void onWebCreatedGrodsoil(webController) {
    this.webController = webController;
    this.webController.loadUrl(soil);
    this.webController.onPageStarted.listen((url) => print("Loading $url"));
    this
        .webController
        .onPageFinished
        .listen((url) => print("Finished loading $url"));
  }

  void onWebCreatedGrodwater(webController) {
    this.webController = webController;
    this.webController.loadUrl(water);
    this.webController.onPageStarted.listen((url) => print("Loading $url"));
    this
        .webController
        .onPageFinished
        .listen((url) => print("Finished loading $url"));
  }

  void onWebCreatedGrodfil(webController) {
    this.webController = webController;
    this.webController.loadUrl(fil);
    this.webController.onPageStarted.listen((url) => print("Loading $url"));
    this
        .webController
        .onPageFinished
        .listen((url) => print("Finished loading $url"));
  }

//#########################################################################################################################################
  final tabs = [
    Center(
        child: Image.network(
            'https://thingspeak.com/channels/1082376/charts/1?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line')),
    Center(
        child: Image.network(
            'https://thingspeak.com/channels/1082376/charts/3?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line')),
    Center(
        child: Image.network(
            'https://thingspeak.com/channels/1082376/charts/2?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15')),
  ];
//######################################################################################################################SS
  @override
  Widget build(BuildContext context) {
    FlutterNativeWeb flutterNativeWebsoil = new FlutterNativeWeb(
      onWebCreated: onWebCreatedGrodsoil,
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
        Factory<OneSequenceGestureRecognizer>(
          () => TapGestureRecognizer(),
        ),
      ].toSet(),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('           My Show Data App'),
      ),
      body: tabs[_currentIndes],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndes,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              
                icon: Icon(Icons.nature_sharp),
                // ignore: deprecated_member_use
                title: Text('Soil moisture'),
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.opacity),
                // ignore: deprecated_member_use
                title: Text('Water level'),
                backgroundColor: Colors.red),
            BottomNavigationBarItem(
                icon: Icon(Icons.filter_hdr_rounded),
                // ignore: deprecated_member_use
                title: Text('Fertilizer cost'),
                backgroundColor: Colors.green),
          ],
          onTap: (index) {
            setState(() {
              _currentIndes = index;
            });
          }),
    );
  }

  // Widget grod(BuildContext context) {
  //   FlutterNativeWeb flutterNativeWeb = new FlutterNativeWeb(
  //     onWebCreated: onWebCreatedGrodsoil,
  //     gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
  //       Factory<OneSequenceGestureRecognizer>(
  //         () => TapGestureRecognizer(),
  //       ),
  //     ].toSet(),
  //   );
  //   return Container(
  //     child: Form(
  //       key: formkey,
  //       child: Column(
  //         children: [
  //           Container(
  //             padding: EdgeInsets.only(top: 20.0, right: 10.0, left: 5.0),
  //             child: flutterNativeWeb,
  //             height: 300.0,
  //             width: 500.0,
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
