import 'package:apppro/main.dart';
import 'package:apppro/screens/home.dart';
import 'package:apppro/screens/mode.dart';
import 'package:apppro/screens/set.dart';
import 'package:apppro/screens/show.dart';
import 'package:apppro/screens/showg.dart';
import 'package:apppro/screens/showgrod.dart';
import 'package:apppro/utility/normai.dart';
import 'package:apppro/screens/setup.dart';
import 'package:apppro/utility/my_sety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_web/flutter_native_web.dart';

class Homee extends StatefulWidget {
  @override
  _HomeeState createState() => _HomeeState();
}

class _HomeeState extends State<Homee> {
  String soil =
      'https://thingspeak.com/channels/1082376/charts/1?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line';
  String water =
      'https://thingspeak.com/channels/1082376/charts/3?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line';
  String fil =
      'https://thingspeak.com/channels/1082376/charts/2?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15';
  String waterfil =
      'https://thingspeak.com/channels/1082376/charts/4?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15';
  WebController webController,
      webControllerwater,
      webControllerfil,
      webControllerwaterfil;
  FirebaseDatabase firebaseDatabasesoil = FirebaseDatabase.instance;
  FirebaseDatabase firebaseDatabasewater = FirebaseDatabase.instance;
  FirebaseDatabase firebaseDatabasefil = FirebaseDatabase.instance;
  FirebaseDatabase firebaseDatabasewaterfil = FirebaseDatabase.instance;
  Map<dynamic, dynamic> canDatabasnsoil,
      canDatabasnwater,
      canDatabasnfil,
      canDatabasnwaterfil;
  int waterfire, fertilizerfire, soilfile, waterfile;
 
//###############################################################################
  // void getvalueFromFirebasesoil() async {
  //   DatabaseReference databaseReference =
  //       await firebaseDatabasesoil
  //       .reference()
  //       .onValue().
  //       then((objValue) {
  //     canDatabasnsoil = objValue.value;
  //     setState(() {
  //       soilfile = canDatabasnsoil['Soil Moisture1'];
  //       print('soil =$soilfile');
  //     });
  //   });
  // }

  // void editFirebase(String nodeString, int value) async {
  //   print('node ==>$nodeString');
  //   canDatabasnsoil['$nodeString'] = value;
  //   await firebaseDatabasesoil.reference().set(canDatabasnsoil).then(
  //     (objValue) {
  //       print('$nodeString Success');
  //       getvalueFromFirebasesoil();
  //     },
  //   ).catchError(
  //     (objValue) {
  //       String error = objValue.message;
  //       print('error ==> $error');
  //     },
  //   );
  // }
//####
// void getvalueFromFirebasewater() async {
//     DatabaseReference databaseReference1 =await firebaseDatabasewater
//         .reference()
//         .onValue()
//         .then((objValue1) {
//       canDatabasnwater = objValue1.value;
//       setState(() {
//         waterfire= canDatabasnwater['Distance1'];
//         print('water =$waterfire');
//       });
//     });
//   }

//   void editFirebase1(String nodeString, int value) async {
//     print('node ==>$nodeString');
//     canDatabasnwater['$nodeString'] = value;
//     await firebaseDatabasewater.reference().set(canDatabasnwater).then(
//       (objValue1) {
//         print('$nodeString Success');
//         getvalueFromFirebasewater();
//       },
//     ).catchError(
//       (objValue1) {
//         String error = objValue1.message;
//         print('error ==> $error');
//       },
//     );
//   }
//####
  void listenToFirebase() {
    FirebaseDatabase.instance
        .reference()
        .child("Soil Moisture1")
        .onValue
        .listen((Event user) {
      print("user = " + user.snapshot.value.toString());
    }).onData((Event event) {
      print("Error = $event");
    });
  }

//##############################################################################

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

  void onWebCreatedGrodwaterfil(webControllerwaterfil) {
    this.webControllerwaterfil = webControllerwaterfil;
    this.webControllerwaterfil.loadUrl(waterfil);
    this
        .webControllerwaterfil
        .onPageStarted
        .listen((url) => print("Loading $url"));
    this
        .webControllerwaterfil
        .onPageFinished
        .listen((url) => print("Finished loading $url"));
  }

  Widget sigOut(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      tooltip: 'Log Out',
      onPressed: () {
        myAlert();
      },
    );
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are You Sure ?'),
            content: Text('Do You Whnt Log Out ?'),
            actions: <Widget>[canel(), okBu(context)],
          );
        });
  }

  Widget okBu(BuildContext context) {
    return FlatButton(
      child: Text('OK'),
      onPressed: () {
        Navigator.of(context).pop();
        myLogOut(context);
      },
    );
  }

  Future<void> myLogOut(BuildContext context) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signOut().then((respose) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => Home());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    });
  }

  Widget canel() {
    return FlatButton(
      child: Text('Cancel'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    listenToFirebase();
    //getvalueFromFirebasesoil();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('             My Home App'),
        actions: <Widget>[sigOut(context)],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                "System setup",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                child: Image.asset('images/told.png'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.construction_outlined),
              title: Text(
                "Control",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Setup()));
              },
            ),
            ListTile(
              leading: Icon(Icons.dialpad_outlined),
              title: Text(
                "Setdata",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Set1()));
              },
            ),
            ListTile(
              leading: Icon(Icons.developer_board),
              title: Text(
                "Manual",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Mode()));
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //testtt(),
              grodsoil(context),
              grodwater(context),
              grodfil(context),
              grodwaterfil(context),
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
          width: 400.0,
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
          width: 400.0,
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
          width: 400.0,
        )
      ],
    );
  }

  Widget grodwaterfil(BuildContext context) {
    FlutterNativeWeb flutterNativeWebwaterfil = new FlutterNativeWeb(
      onWebCreated: onWebCreatedGrodwaterfil,
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
        Factory<OneSequenceGestureRecognizer>(
          () => TapGestureRecognizer(),
        ),
      ].toSet(),
    );
    return Column(
      children: [
        Text(
          'Water Fertilizer',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 20.0, right: 10.0, left: 5.0),
          child: flutterNativeWebwaterfil,
          height: 300.0,
          width: 400.0,
        )
      ],
    );
  }

  Widget testtt() {
    return Column(
      children: [Text('soil =$Event')],
    );
  }
//###############################################################################
  //     body: Center(
  //       child: SingleChildScrollView(
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             MySety().showlog(),
  //             MySety().mySizedBox(),
  //             myButtonsetup(),
  //             MySety().mySizedBox(),
  //             myButtonset(),
  //             MySety().mySizedBox(),
  //             myButtonshow(),
  //             MySety().mySizedBox(),
  //             myButtonmode(),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget loginButton() {
  //   return Row(children: [
  //     Expanded(
  //       child: RaisedButton(
  //         color: Colors.blue,
  //         child: Text(
  //           'control'.toUpperCase(),
  //           style: TextStyle(fontSize: 16, color: Colors.white),
  //         ),
  //         onPressed: () {
  //           Navigator.push(
  //               context, MaterialPageRoute(builder: (context) => Setup()));
  //         },
  //       ),
  //     )
  //   ]);
  // }

  // Widget myButtonsetup() => Container(
  //       width: 300.0,
  //       child: RaisedButton(
  //         color: MySety().bolColor,
  //         onPressed: () {
  //           Navigator.push(
  //               context, MaterialPageRoute(builder: (context) => Setup()));
  //         },
  //         child: Text(
  //           'Control',
  //           style: TextStyle(fontSize: 20, color: Colors.white),
  //         ),
  //       ),
  //     );

  // Widget myButtonset() => Container(
  //       width: 300.0,
  //       child: RaisedButton(
  //         color: MySety().bolColor,
  //         onPressed: () {
  //           Navigator.push(
  //               context, MaterialPageRoute(builder: (context) => Set1()));
  //         },
  //         child: Text(
  //           'Setdata',
  //           style: TextStyle(fontSize: 20, color: Colors.white),
  //         ),
  //       ),
  //     );

  // Widget myButtonshow() => Container(
  //       width: 300.0,
  //       child: RaisedButton(
  //         color: MySety().bolColor,
  //         onPressed: () {
  //           Navigator.push(
  //               context, MaterialPageRoute(builder: (context) => Showgrod()));
  //         },
  //         child: Text(
  //           'Show Graph',
  //           style: TextStyle(fontSize: 20, color: Colors.white),
  //         ),
  //       ),
  //     );

  // Widget myButtonmode() => Container(
  //       width: 300.0,
  //       child: RaisedButton(
  //         color: MySety().bolColor,
  //         onPressed: () {
  //           // Navigator.pushAndRemoveUntil(
  //           //   context,
  //           //   MaterialPageRoute(builder: (context) => Homee()),
  //           //   (Route<dynamic> route) => false,
  //           // );
  //           // Navigator.pushAndRemoveUntil(
  //           //   context,
  //           //   MaterialPageRoute(builder: (context) => Mode()),
  //           //   (Route<dynamic> route) => false,
  //           // );
  //           Navigator.push(
  //               context, MaterialPageRoute(builder: (context) => Mode()));
  //         },
  //         child: Text(
  //           'Manual',
  //           style: TextStyle(fontSize: 20, color: Colors.white),
  //         ),
  //       ),
  //     );

}
