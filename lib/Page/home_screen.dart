// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospitalapp01/Widget/SignUp_widget.dart';
import 'package:hospitalapp01/Widget/login_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return FormScreen();
            } else if (snapshot.hasError) {
              return Center(child: Text('มีข้อผิดพลาดเกิดขึ้น!'));
            } else {
              return SignUpWidget();
            }
          },
        ),
      );
}
