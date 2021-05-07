import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_web/flutter_native_web.dart';

class Showgrod extends StatefulWidget {
  @override
  _ShowgrodState createState() => _ShowgrodState();
}

class _ShowgrodState extends State<Showgrod> {
  String soil =
      'https://thingspeak.com/channels/1082376/charts/1?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line';
  String water =
      'https://thingspeak.com/channels/1082376/charts/3?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line';
  String fil =
      'https://thingspeak.com/channels/1082376/charts/2?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15';
  WebController webController, webControllerwater, webControllerfil;

  void onWebCreatedGrodsoil(webController) {
    this.webController = webController;
    this.webController.loadUrl(soil);
    this.webController.onPageStarted.listen((url) => print("Loading $url"));
    this
        .webController
        .onPageFinished
        .listen((url) => print("Finished loading $url"));
  }

  void onWebCreatedGrodwater(webControllerwater) {
    this.webControllerwater = webControllerwater;
    this.webControllerwater.loadUrl(water);
    this
        .webControllerwater
        .onPageStarted
        .listen((url) => print("Loading $url"));
    this
        .webControllerwater
        .onPageFinished
        .listen((url) => print("Finished loading $url"));
  }

  void onWebCreatedGrodfil(webControllerfil) {
    this.webControllerfil = webControllerfil;
    this.webControllerfil.loadUrl(fil);
    this.webControllerfil.onPageStarted.listen((url) => print("Loading $url"));
    this
        .webControllerfil
        .onPageFinished
        .listen((url) => print("Finished loading $url"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('           My Show Data App'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              grodsoil(context),
              grodwater(context),
              grodfil(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget grodsoil(BuildContext context) {
    FlutterNativeWeb flutterNativeWebsoil = new FlutterNativeWeb(
      onWebCreated: onWebCreatedGrodsoil,
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
        Factory<OneSequenceGestureRecognizer>(
          () => TapGestureRecognizer(),
        ),
      ].toSet(),
    );
    return Column(
      children: [
        Text(
          'Soil MoistureSoil',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 20.0, right: 10.0, left: 5.0),
          child: flutterNativeWebsoil,
          height: 300.0,
          width: 450.0,
        )
      ],
    );
  }

  Widget grodwater(BuildContext context) {
    FlutterNativeWeb flutterNativeWebwater = new FlutterNativeWeb(
      onWebCreated: onWebCreatedGrodwater,
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
        Factory<OneSequenceGestureRecognizer>(
          () => TapGestureRecognizer(),
        ),
      ].toSet(),
    );
    return Column(
      children: [
        Text(
          'Water',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 20.0, right: 10.0, left: 5.0),
          child: flutterNativeWebwater,
          height: 300.0,
          width: 450.0,
        )
      ],
    );
  }

  Widget grodfil(BuildContext context) {
    FlutterNativeWeb flutterNativeWebfil = new FlutterNativeWeb(
      onWebCreated: onWebCreatedGrodfil,
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
        Factory<OneSequenceGestureRecognizer>(
          () => TapGestureRecognizer(),
        ),
      ].toSet(),
    );
    return Column(
      children: [
        Text(
          'Fertilizer',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 20.0, right: 10.0, left: 5.0),
          child: flutterNativeWebfil,
          height: 300.0,
          width: 450.0,
        )
      ],
    );
  }
}
