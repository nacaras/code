import 'package:apppro/main.dart';
import 'package:apppro/utility/my_sety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:firebase_database/firebase_database.dart';

void main() => runApp(MyApp());

class Setup extends StatefulWidget {
  @override
  _SetupState createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  FirebaseDatabase firebaseDatabase1 = FirebaseDatabase.instance;
  FirebaseDatabase firebaseDatabase2 = FirebaseDatabase.instance;
  FirebaseDatabase firebaseDatabase3 = FirebaseDatabase.instance;
  Map<dynamic, dynamic> canDatabasn, canDatabasn1, canDatabasn2, canDatabasn3;
  int waterfire, fertilizerfire, modefire, soilfire, statusfire, moterfire;
  String mode = " ", water = '', fertilizer = '', soil = '', moter = '';
  bool status = true;

  disableButton() {
    setState(() {
      status = false;
    });
  }

  enableButton() {
    setState(() {
      status = true;
    });
  }

//##############################################################################
  void getvalueFromFirebase() async {
    DatabaseReference databaseReference = await firebaseDatabase
        .reference()
        //.child('Equipment')
        .once()
        .then((objValue) {
      canDatabasn = objValue.value;
      setState(() {
        modefire = canDatabasn['Mode'];
        print('Mode =$modefire');
        if (modefire == 1) {
          mode = 'Auto';
        } else {
          mode = 'Manual';
        }
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
    DatabaseReference databaseReference1 = await firebaseDatabase1
        .reference()
        //.child('delay')
        .once()
        .then((objValue1) {
      canDatabasn1 = objValue1.value;
      setState(() {
        waterfire = canDatabasn1['water'];
        print('water =$waterfire');
        if (waterfire == 1) {
          water = 'ON';
        } else {
          water = 'OFF';
        }
      });
    });
  }

  void editFirebase1(String nodeString1, int value1) async {
    print('node ==>$nodeString1');

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

//##############################################################################
  void getvalueFromFirebase2() async {
    DatabaseReference databaseReference2 = await firebaseDatabase2
        .reference()
        //.child('delay')
        .once()
        .then((objValue2) {
      canDatabasn2 = objValue2.value;
      setState(() {
        fertilizerfire = canDatabasn2['fertilizer'];
        print('fertilizer =$fertilizerfire');
        if (fertilizerfire == 1) {
          fertilizer = 'ON';
        } else {
          fertilizer = 'OFF';
        }
      });
    });
  }

  void editFirebase2(String nodeString2, int value2) async {
    print('node ==>$nodeString2');

    canDatabasn2['$nodeString2'] = value2;

    await firebaseDatabase2.reference().set(canDatabasn2).then(
      (objValue1) {
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

//##############################################################################

//################################################################################
  @override
  void initState() {
    super.initState();
    getvalueFromFirebase();
    getvalueFromFirebase1();
    getvalueFromFirebase2();
    //getvalueFromFirebase3();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('             My Setup App'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MySety().sizedBox(),
              contenrswit(),
            ],
          ),
        ),
      ),
    );
  }

  Widget contenrswit() {
    return Center(
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            MySety().showsystem(),
            MySety().sizedBox(),
            modeButton(),
            MySety().sizedBox(),
            waterButton(),
            MySety().sizedBox(),
            fertilizerButton(),
            MySety().sizedBox(),
            // motorButton(),
          ],
        ),
      ),
    );
  }

  Widget modeButton() => Container(
        height: 50.0,
        width: 300.0,
        child: RaisedButton(
          color: Colors.black,
          onPressed: () {
            if (modefire == 1) {
              editFirebase('Mode', 0);
              print('Mode =$modefire');
            } else {
              editFirebase('Mode', 1);
              print('Mode =$modefire');
            }
          },
          child: Text(
            'Mode  => $mode',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      );

  Widget waterButton() => Container(
        height: 50.0,
        width: 300.0,
        child: RaisedButton(
          color: Colors.blue,
          onPressed: () {
            if (waterfire == 1) {
              editFirebase1('water', 0);
              print('waterfire =$waterfire');
              //water = 'OFF';
            } else {
              editFirebase1('water', 1);
              print('waterfire =$waterfire');
              //water = 'ON';
            }
          },
          child: Text(
            'Water  => $water',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      );
  Widget fertilizerButton() => Container(
        height: 50.0,
        width: 300.0,
        child: RaisedButton(
          color: Colors.blue,
          onPressed: () {
            if (fertilizerfire == 1) {
              editFirebase2('fertilizer', 0);
              print('fertilizerfire =$fertilizerfire');
            } else {
              editFirebase2('fertilizer', 1);
              print('fertilizerfire =$fertilizerfire');
            }
          },
          child: Text(
            'fertilizer  => $fertilizer',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      );
}
