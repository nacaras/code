import 'dart:ui';

import 'package:apppro/screens/setup.dart';
import 'package:apppro/utility/my_sety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class Set1 extends StatefulWidget {
  @override
  _SetState createState() => _SetState();
}

class _SetState extends State<Set1> {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  FirebaseDatabase firebaseDatabase1 = FirebaseDatabase.instance;
  FirebaseDatabase firebaseDatabase2 = FirebaseDatabase.instance;
  FirebaseDatabase setfirebaseDatabase = FirebaseDatabase.instance;
  String soilInt, waterInt, fertilizerInt;
  final number = TextEditingController();
  final formkey = GlobalKey<FormState>();
  Map<dynamic, dynamic> canDatabasn, canDatabasn1, canDatabasn2;
  int distancefire, fertilizerfire, soilfire;

  void getvalueFromFirebase() async {
    DatabaseReference databaseReference = await firebaseDatabase
        .reference()
        .child('sensor')
        .once()
        .then((objValue) {
      canDatabasn = objValue.value;
      setState(() {
        distancefire = canDatabasn['Distance'];
        print('distance =$distancefire');
      });
    });
  }

  void editFirebase(String nodeString, int value) async {
    print('node ==>$nodeString');
    canDatabasn['$nodeString'] = value;
    await firebaseDatabase.reference().set(canDatabasn).then(
      (objValue) {
        print('$nodeString Success');
        getvalueFromFirebase();
      },
    ).catchError(
      (objValue) {
        String error = objValue.message;
        print('error ==> $error');
      },
    );
  }

//##############################################################################
  void getvalueFromFirebase1() async {
    DatabaseReference databaseReference1 = await firebaseDatabase
        .reference()
        .child('sensor')
        .once()
        .then((objValue1) {
      canDatabasn1 = objValue1.value;
      setState(() {
        fertilizerfire = canDatabasn1['Fertility'];
        print('Fertility =$fertilizerfire');
      });
    });
  }

  void editFirebase1(String nodeString1, int value1) async {
    print('node1 ==>$nodeString1');
    canDatabasn1['$nodeString1'] = value1;
    await firebaseDatabase1.reference().set(canDatabasn1).then(
      (objValue1) {
        print('$nodeString1 Success');
        getvalueFromFirebase1();
      },
    ).catchError(
      (objValue1) {
        String error = objValue1.message;
        print('error ==> $error');
      },
    );
  }

  //############################################################################
  void getvalueFromFirebase2() async {
    DatabaseReference databaseReference2 = await firebaseDatabase
        .reference()
        .child('sensor')
        .once()
        .then((objValue2) {
      canDatabasn2 = objValue2.value;
      setState(() {
        soilfire = canDatabasn2['Soil Moisture'];
        print('Soil Moisture =$soilfire');
      });
    });
  }

  void editFirebase2(String nodeString2, int value2) async {
    print('node1 ==>$nodeString2');
    canDatabasn2['$nodeString2'] = value2;
    await firebaseDatabase2.reference().set(canDatabasn2).then(
      (objValue2) {
        print('$nodeString2 Success');
        getvalueFromFirebase2();
      },
    ).catchError(
      (objValue2) {
        String error = objValue2.message;
        print('error ==> $error');
      },
    );
  }

  //############################################################################
  void uplodetoFirebase(BuildContext context) async {
    var soil1 = int.parse(soilInt);
    var fertilizer1 = int.parse(fertilizerInt);
    var water1 = int.parse(waterInt);
    DatabaseReference databaseReference =
        firebaseDatabase.reference().child('sensor');
    await databaseReference.once().then((DataSnapshot dataSnapshot) {
      Map<dynamic, dynamic> map = dataSnapshot.value;
      print('setsoil=$soilInt,setfir=$fertilizerInt, setwater=$waterInt');
      map['Soil Moisture'] = soil1;
      map['Fertility'] = fertilizer1;
      map['Distance'] = water1;

      sentDatatoFirebase(map, context);
    });
  }

//##############################################################################
  void sentDatatoFirebase(Map map, BuildContext context) async {
    await setfirebaseDatabase
        .reference()
        .child('sensor')
        .set(map)
        .then((objValue) {
      // var showServiceRoute =
      //     MaterialPageRoute(builder: (BuildContext context) => ShowServic());
      // Navigator.of(context).push(showServiceRoute);
    }).catchError((objValue) {
      String errorString = objValue.message;
    });
  }

//####################################################################################
  @override
  void initState() {
    super.initState();
    getvalueFromFirebase();
    getvalueFromFirebase1();
    getvalueFromFirebase2();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('              My Set App'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              content(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildtext(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 280,
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: number,
                autocorrect: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Enter Your Number Here'),
              )),
        ],
      ),
    ));
  }

  Widget setMotor() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200.0,
            child: TextField(
              onChanged: (value) => soilInt = value.trim(),
              autocorrect: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'ความชื้นในดิน=$soilfire',
                prefixIcon: Icon(Icons.grass),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Widget setwotor() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200.0,
            child: TextField(
              onChanged: (value) => waterInt = value.trim(),
              autocorrect: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'ระดับน้ำ=$distancefire',
                prefixIcon: Icon(Icons.invert_colors_on_outlined),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Widget setfertilizer() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200.0,
            child: TextField(
              onChanged: (value) => fertilizerInt = value.trim(),
              autocorrect: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'ปุ๋ยในดิน=$fertilizerfire',
                prefixIcon: Icon(Icons.local_florist_outlined),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Widget uploadButton(BuildContext context) => Container(
        width: 300.0,
        child: RaisedButton(
          color: MySety().bolColor,
          onPressed: () {
            if (formkey.currentState.validate()) {
              formkey.currentState.save();
              uplodetoFirebase(context);
              show();
            }
          },
          child: Text(
            'Upload',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      );

  Widget content(BuildContext context) {
    return Center(
      child: Form(
        key: formkey,
        child: Column(
          children: <Widget>[
            MySety().sizedBox(),
            setMotor(),
            MySety().sizedBox(),
            setwotor(),
            MySety().sizedBox(),
            setfertilizer(),
            MySety().sizedBox(),
            uploadButton(context),
            MySety().sizedBox(),
          ],
        ),
      ),
    );
  }

  void show() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(
              'Upload Data',
              style: TextStyle(fontSize: 20.0),
            ),
            content: Text(
              'ระดับน้ำ == $waterInt\n'
              'ความชื้นในดิน == $soilInt\n'
              'ปุ๋ยในดิน == $fertilizerInt',
              style: TextStyle(fontSize: 18.0),
            ),
            actions: <Widget>[okBu(context)],
          );
        });
  }

  Widget okBu(BuildContext context) {
    return FlatButton(
      child: Text('OK'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
