import 'package:flutter/material.dart';

class MySety {
  Color darkColor = Colors.greenAccent.shade700;
  Color foneColor = Colors.red;
  Color dartColor = Colors.black;
  Color bolColor = Colors.blue;

  SizedBox mySizedBox() => SizedBox(
        width: 8.0,
        height: 16.0,
      );

  SizedBox sizedBox() => SizedBox(
        width: 10.0,
        height: 20.0,
      );

  Text showti(String ti) => Text(
        ti,
        style: TextStyle(
          fontSize: 25.0,
          color: Colors.greenAccent.shade700,
          fontWeight: FontWeight.bold,
        ),
      );

  Container showlogo() {
    return Container(
      width: 120.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Container showlog() {
    return Container(
      width: 120.0,
      child: Image.asset('images/told.png'),
    );
  }

  Container mode1() {
    return Container(
      width: 400.0,
      height: 400.0,
      child: Image.asset('images/77.png'),
    );
  }

  Container mode2() {
    return Container(
      width: 500.0,
      height: 500.0,
      child: Image.asset('images/88.png'),
    );
  }

  Container mode3() {
    return Container(
      width: 500.0,
      height: 500.0,
      child: Image.asset('images/99.png'),
    );
  }

  Container mode4() {
    return Container(
      width: 500.0,
      height: 500.0,
      child: Image.asset('images/5.jpg'),
    );
  }

  Container mode5() {
    return Container(
      width: 400.0,
      height: 400.0,
      child: Image.asset('images/6.jpg'),
    );
  }

  Container mode6() {
    return Container(
      width: 400.0,
      height: 400.0,
      child: Image.asset('images/7.jpg'),
    );
  }

  Container showsystem() {
    return Container(
      width: 120.0,
      height: 120.0,
      child: Image.asset('images/systemg.png'),
    );
  }

  Container moo() {
    return Container(
      width: 400.0,
      height: 400.0,

      child: Text(
        "ผู้จัดทำ ",
        style: TextStyle(
          fontSize: 16.0,
          color: foneColor,
        ),
      ),
    );
  }

  MySety();
}
