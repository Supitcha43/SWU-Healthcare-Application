// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hospitalapp01/provider/google_signIn.dart';
import 'package:provider/provider.dart';

class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.fromLTRB(50, 60, 60, 50),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Spacer(flex: 2),
        Image(image: AssetImage('assets/icons/TBOT APP icon4.png')),
        const Spacer(flex: 1),
        Align(
          alignment: Alignment.center,
          child: Text(
            'Welcome to',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.center,
          child: Text(
            'SWU Healthcare Application',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ),
        SizedBox(height: 8),
        const Spacer(flex: 1),
        Align(
          alignment: Alignment.center,
          child: Text(
            'กรุณาลงชื่อเข้าใช้ด้วยบัญชีกูเกิ้ล',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const Spacer(),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.black,
            minimumSize: Size(double.infinity, 50),
          ),
          icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
          label: Text('Sign Up with Google'),
          onPressed: () {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.googleLogin();
          },
        ),
        SizedBox(height: 40),
        const Spacer(),
      ]));
}
