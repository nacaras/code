import 'package:apppro/main.dart';
import 'package:apppro/screens/home1.dart';
import 'package:apppro/utility/my_sety.dart';
import 'package:apppro/utility/normai.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final formkey = GlobalKey<FormState>();
  String email, password;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    checlogin(context);
  }
  //   Future<User> currentUser() async {
  //   final GoogleSignInAccount account = await googleSignIn.signIn();
  //   final GoogleSignInAuthentication authentication =
  //       await account.authentication;

  //   final GoogleAuthCredential credential = GoogleAuthProvider.credential(
  //       idToken: authentication.idToken,
  //       accessToken: authentication.accessToken);

  //   final UserCredential authResult =
  //       await _auth.signInWithCredential(credential);
  //   final User user = authResult.user;

  //   return user;
  // }
  // Future<void> checlogin(BuildContext context) async {
  //   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //   FirebaseUser firebaseUser = await firebaseAuth.currentUser();
  //   if (FirebaseUser != null) {
  //     MaterialPageRoute materialPageRoute =
  //         MaterialPageRoute(builder: (BuildContext context) => Homee());
  //     Navigator.of(context).pushAndRemoveUntil(
  //         materialPageRoute, (Route<dynamic> route) => false);
  //   }
  // }
  void checlogin(BuildContext context) async {
    final User user = await firebaseAuth.currentUser;
    print('OK ');
    if (user != null) {
      print('OK User');
      checloginfirebase(context);
    }
  }

  void checloginfirebase(BuildContext context) {
    var myServiceRoute =
        MaterialPageRoute(builder: (BuildContext context) => Homee());
    Navigator.of(context)
        .pushAndRemoveUntil(myServiceRoute, (Route<dynamic> route) => false);
  }

  Widget content(BuildContext context) {
    return Center(
        child: Form(
      key: formkey,
      child: Column(
        children: <Widget>[
          MySety().showlogo(),
          MySety().mySizedBox(),
          MySety().showti('Welcome'),
          MySety().mySizedBox(),
          userfrom(),
          MySety().mySizedBox(),
          passwordfrom(),
          MySety().mySizedBox(),
          myButtonlogin(context),
        ],
      ),
    ));
  }

  void checauth(BuildContext context) async {
    await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((response) {
      print('Auth Succ');
      var mySevericeRoute = MaterialPageRoute(
        builder: (BuildContext context) => Homee(),
      );
      Navigator.of(context)
          .pushAndRemoveUntil(mySevericeRoute, (Route<dynamic> route) => false);
      // MaterialPageRoute materialPageRoute =
      //     MaterialPageRoute(builder: (BuildContext context) => Homee());
      // Navigator.of(context).pushNamedAndRemoveUntil(
      //     materialPageRoute, (Route<dynamic> route) => false);
    }).catchError(
      (response) {
        String title = response.code;
        String messge = response.messge;
        myAlert(title, messge);
      },
    );
  }

  Widget showtitext(String title) {
    return ListTile(
      leading: Icon(
        Icons.add_alert,
        size: 48.0,
        color: Colors.red,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.red,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget okBu() {
    return FlatButton(
      child: Text('OK'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  void myAlert(String title, String messge) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: showtitext(title),
            content: Text(messge),
            actions: <Widget>[okBu()],
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
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

  Widget myButtonlogin(BuildContext context) => Container(
        width: 250.0,
        child: RaisedButton(
          color: MySety().foneColor,
          onPressed: () {
            print('email=$email,password=$password');
            if (email == null ||
                email.isEmpty ||
                password == null ||
                password.isEmpty) {
              normai(context, 'Please enter correct information.');
            } else if (formkey.currentState.validate()) {
              formkey.currentState.save();
              checauth(context);
            }
          },
          child: Text('LOGIN'),
        ),
      );

  Widget userfrom() => Container(
        width: 250.0,
        child: TextFormField(
          onChanged: (value) => email = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.email),
            labelStyle: TextStyle(color: MySety().darkColor),
            labelText: 'E-mail',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MySety().darkColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MySety().foneColor)),
          ),
          onSaved: (String value) {
            email = value.trim();
          },
        ),
      );

  Widget passwordfrom() => Container(
        width: 250.0,
        child: TextFormField(
            onChanged: (value) => password = value.trim(),
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.vpn_key),
              labelStyle: TextStyle(color: MySety().darkColor),
              labelText: 'password',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MySety().darkColor)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MySety().foneColor)),
            ),
            onSaved: (String value) {
              password = value.trim();
            }),
      );
}

// class ( {
// }
//######################################################################################################################
//       Widget buildLoginBtn() {
//         return Container(
//           padding: EdgeInsets.symmetric(vertical: 20.0),
//           width: double.infinity,
//           child: RaisedButton(
//             elevation: .0,
//             onPressed: () {
//               if (email == null ||
//                   email.isEmpty ||
//                   password == null ||
//                   password.isEmpty) {
//                 normai(context, 'Please enter correct information.');
//               } else {
//                 Navigator.push(
//                     context, MaterialPageRoute(builder: (context) => Homee()));
//               }
//             },
//             padding: EdgeInsets.all(10.0),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(30.0),
//             ),
//             color: Colors.white,
//             child: Text(
//               'LOGIN',
//               style: TextStyle(
//                 color: Color(0xFF527DAA),
//                 letterSpacing: 1.5,
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'OpenSans',
//               ),
//             ),
//           ),
//         );
//       }
//     }

//     class ( {
// }
