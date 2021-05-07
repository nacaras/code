// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_native_web/flutter_native_web.dart';

// class AutoControl extends StatefulWidget {
  

  
//   // AutoControl(this.currentUser);

//   @override
//   _AutoControlState createState() => _AutoControlState();
// }

// class _AutoControlState extends State<AutoControl> {
 
//   final formKey = GlobalKey<FormState>();

//   WebController webControllerPh,
//       webControllerTurbidity,
//       webControllerTemperature;

//   @override
//   void initState() {
//     super.initState();
  
//   }

//   void onWebCreated(webControllerPh) {
//     this.webControllerPh = webControllerPh;

//     this.webControllerPh.loadUrl(
//         'https://thingspeak.com/channels/1082376/charts/2?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15');

//     this.webControllerPh.onPageStarted.listen((url) => print("Loading $url"));

//     this
//         .webControllerPh
//         .onPageFinished
//         .listen((url) => print("Finished loading $url"));
//   }

//   void onWebCreatedTurbidity(webControllerTurbidity) {
//     this.webControllerTurbidity = webControllerTurbidity;

//     this.webControllerTurbidity.loadUrl(
//         'https://thingspeak.com/channels/1082376/charts/1?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line');

//     this
//         .webControllerTurbidity
//         .onPageStarted
//         .listen((url) => print("Loading $url"));
//     this
//         .webControllerTurbidity
//         .onPageStarted
//         .listen((url) => print("Loading $url"));

//     this
//         .webControllerTurbidity
//         .onPageFinished
//         .listen((url) => print("Finished loading $url"));
//   }

//   void onWebCreatedTemperature(webControllerTemperature) {
//     this.webControllerTemperature = webControllerTemperature;

//     this.webControllerTemperature.loadUrl(
//         'https://thingspeak.com/channels/1082376/charts/3?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line');

//     this
//         .webControllerTemperature
//         .onPageStarted
//         .listen((url) => print("Loading $url"));
//     this
//         .webControllerTemperature
//         .onPageStarted
//         .listen((url) => print("Loading $url"));

//     this
//         .webControllerTemperature
//         .onPageFinished
//         .listen((url) => print("Finished loading $url"));
//   }

//   bool checkSpace(String value) {
//     bool result = false;
//     if (value.length == 0) {
//       result = true;
//     }
//     return result;
//   }

//   @override
//   Widget build(BuildContext context) {
//     // SystemChrome.setPreferredOrientations(
//     //     [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
//     FlutterNativeWeb flutterPh = FlutterNativeWeb(
//       onWebCreated: onWebCreated,
//       gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
//         Factory<OneSequenceGestureRecognizer>(
//           () => TapGestureRecognizer(),
//         ),
//       ].toSet(),
//     );

//     FlutterNativeWeb flutterTubidity = FlutterNativeWeb(
//       onWebCreated: onWebCreatedTurbidity,
//       gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
//         Factory<OneSequenceGestureRecognizer>(
//           () => TapGestureRecognizer(),
//         ),
//       ].toSet(),
//     );

//     FlutterNativeWeb flutterTemperature = FlutterNativeWeb(
//       onWebCreated: onWebCreatedTemperature,
//       gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
//         Factory<OneSequenceGestureRecognizer>(
//           () => TapGestureRecognizer(),
//         ),
//       ].toSet(),
//     );

//     return DefaultTabController(
//       length: 4,
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text(
//             "Auto Control",
//             style: TextStyle(
//                 fontSize: 18,
//                 fontFamily: "circe",
//                 fontWeight: FontWeight.bold,
//                 fontStyle: FontStyle.normal),
//           ),
//           bottom: TabBar(
//             isScrollable: true,
//             tabs: <Widget>[
//               Tab(text: 'Water'),
//               Tab(text: 'Moisture'),
//               Tab(text: 'NPK'),
//               Tab(text: ''),
//             ],
//           ),
//         ),
//         // bottomNavigationBar: BottonBar(),
//         body: TabBarView(
//           children: <Widget>[
//             Container(
//               // color: Colors.yellow
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: flutterTemperature,
//               ),
//                height: 300.0,
//                width: 300.0,
//             ),
//             Container(
//               // color: Colors.orange
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: flutterTubidity,
//               ),
//                height: 300.0,
//                width: 300.0,
//             ),
//             // Container(
//             //   color: Colors.red,
//             // ),
//             Container(
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: flutterPh,
//               ),
//               height: 300.0,
//                width: 300.0,
//             ),
//             ],
//             ),
               
//            ),
//                  );
//   }
              
// }

//   // Widget textfieldPH() {
//   //   return Container(
//   //     child: TextFormField(
//   //       initialValue: setPh,
//   //       inputFormatters: [LengthLimitingTextInputFormatter(2)],
//   //       textAlign: TextAlign.start,
//   //       style: TextStyle(
//   //           color: Colors.lightBlue,
//   //           fontWeight: FontWeight.w900,
//   //           fontFamily: 'circe'),
//   //       keyboardType: TextInputType.number,
//   //       decoration: InputDecoration(
//   //         enabledBorder: OutlineInputBorder(),
//   //         prefixIcon: Icon(Icons.tag_faces),
//   //         labelText: 'Ph',
//   //         suffixText: 'Set : $setPh',
//   //         helperStyle: Mystyle().styleset,
//   //         contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
//   //       ),
//   //       // ignore: missing_return
//   //       validator: (String value) {
//   //         if (checkSpace(value)) {
//   //           return;
//   //         }
//   //       },
//   //       onSaved: (String value) {
//   //         if (value.isNotEmpty) {
//   //           setPh = value.trim();
//   //         }
//   //       },
//   //     ),
//   //   );
//   // }

//   // Widget textfieldTur() {
//   //   return Container(
//   //     child: TextFormField(
//   //       initialValue: setTur,
//   //       inputFormatters: [LengthLimitingTextInputFormatter(1)],
//   //       textAlign: TextAlign.start,
//   //       style: TextStyle(
//   //           color: Colors.greenAccent,
//   //           fontWeight: FontWeight.w900,
//   //           fontFamily: 'circe'),
//   //       keyboardType: TextInputType.number,
//   //       decoration: InputDecoration(
//   //         enabledBorder: OutlineInputBorder(),
//   //         prefixIcon: Icon(Icons.tag_faces),
//   //         labelText: 'Turbidity',
//   //         // helperText: 'Enter setTur',
//   //         // helperText: 'Set : $setTur',
//   //         suffixText: 'Set : $setTur',
//   //         helperStyle: Mystyle().styleset,
//   //         contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
//   //       ),
//   //       // ignore: missing_return
//   //       validator: (String value) {
//   //         if (checkSpace(value)) {
//   //           return;
//   //         }
//   //       },
//   //       onSaved: (String value) {
//   //         // int valueInt = int.parse(value);
//   //         // setTur = value.trim();
//   //         if (value.isNotEmpty) {
//   //           setTur = value.trim();
//   //         }
//   //       },
//   //     ),
//   //   );
//   // }

//   // Widget textfieldTemp() {
//   //   return Container(
//   //     child: TextFormField(
//   //       initialValue: setTemp,
//   //       inputFormatters: [LengthLimitingTextInputFormatter(2)],
//   //       textAlign: TextAlign.start,
//   //       style: TextStyle(
//   //           color: Colors.deepOrangeAccent,
//   //           fontWeight: FontWeight.w900,
//   //           fontFamily: 'circe'),
//   //       keyboardType: TextInputType.number,
//   //       decoration: InputDecoration(
//   //         enabledBorder: OutlineInputBorder(),
//   //         prefixIcon: Icon(Icons.tag_faces),
//   //         labelText: 'Temperature',
//   //         suffixText: 'Set :$setTemp',
//   //         helperStyle: Mystyle().styleset,
//   //         contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
//   //       ),
//   //       // ignore: missing_return
//   //       validator: (String value) {
//   //         if (checkSpace(value)) {
//   //           return;
//   //         }
//   //       },
//   //       onSaved: (String value) {
//   //         if (value.isNotEmpty) {
//   //           setTemp = value.trim();
//   //         }
//   //       },
//   //     ),
//   //   );
//   // }

//   // Widget buttonSet() {
//   //   return Container(
//   //     child: CupertinoButton(
//   //       color: Colors.cyan,
//   //       child: Text('Set',
//   //           style: TextStyle(
//   //               fontSize: 14.0,
//   //               fontWeight: FontWeight.w600,
//   //               color: Colors.black,
//   //               fontStyle: FontStyle.normal,
//   //               fontFamily: 'circe')),
//   //       onPressed: () {
//   //         if (formKey.currentState.validate()) {
//   //           formKey.currentState.save();
//   //           editDatabase();

//   //           Fluttertoast.showToast(
//   //               msg:
//   //                   "Done! \n\nYou Set\n\nPh: $setPh\nTur: $setTur\nTemp: $setTemp \n\nSent To Cloud",
//   //               toastLength: Toast.LENGTH_SHORT,
//   //               gravity: ToastGravity.BOTTOM,
//   //               backgroundColor: Colors.cyanAccent[100],
//   //               textColor: Colors.black,
//   //               timeInSecForIosWeb: 1);
//   //         }
//   //       },
//   //     ),
//   //   );
//   // }
