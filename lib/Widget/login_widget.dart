// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, unused_label, avoid_print, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hospitalapp01/Widget/tabbar_material.dart';
import 'package:hospitalapp01/medel/patient.dart';
import 'package:hospitalapp01/provider/google_signIn.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:form_field_validator/form_field_validator.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  Patient myPatient = Patient();

  final items = ['เพศหญิง', 'เพศชาย'];
  String? gvalue;

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final patientCollection =
      FirebaseFirestore.instance.collection('patientCollection');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebase,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Error"),
            ),
            body: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          final user = FirebaseAuth.instance.currentUser!;

          //Text(DateFormat('dd-MM-yyyy KK:mm:ss a').format(DateTime.now()));
          /* DateTime myDateTime = DateTime.now();
          var formatter = DateFormat.yMMMEd();
          var timeformatter = DateFormat.HOUR24_MINUTE_SECOND; */
          /* var now = DateTime.now(); */
          /* String formattedDate = formatter.format(now); */

          return DefaultTabController(
            length: 2,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Text('SWU Healthcare APP'),
                centerTitle: true,
                leading: Padding(
                  padding: EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        final snackBar = SnackBar(
                            content: Text(
                                ' Name: ' +
                                    user.displayName! +
                                    '\n Email: ' +
                                    user.email!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 16)),
                            backgroundColor:
                                Color.fromARGB(225, 183, 218, 244));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(user.photoURL!),
                      ),
                    ),
                  ),
                ),
                backgroundColor: Color.fromARGB(225, 183, 218, 244),
                actions: [
                  TextButton(
                    child: Icon(Icons.exit_to_app_outlined),
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.logout();
                    },
                  ),
                ],
              ),
              body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                              DateFormat(
                                      '\n วันที่ dd/MM/yyyy \t\t\t เวลา KK:mm')
                                  .format(DateTime.now()),
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Text('\n กรุณากรอกข้อมูลให้ครบถ้วน \n',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                flex: 2,
                                child: TextFormField(
                                  //initialValue: " ",
                                  validator: RequiredValidator(
                                      errorText: "กรุณาป้อนชื่อจริง"),
                                  onSaved: (String? textName) {
                                    myPatient.textName = textName;
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.account_circle_outlined),
                                      border: OutlineInputBorder(),
                                      hintText: "ชื่อจริง"),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: TextFormField(
                                  //initialValue: " ",
                                  validator: RequiredValidator(
                                      errorText: "กรุณาป้อนนามสกุล"),
                                  onSaved: (String? textSurname) {
                                    myPatient.textSurname = textSurname;
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.account_circle_outlined),
                                      border: OutlineInputBorder(),
                                      hintText: "นามสกุล"),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            //initialValue: " ",
                            validator:
                                RequiredValidator(errorText: "กรุณาป้อนอายุ"),
                            onSaved: (String? textNumAge) {
                              myPatient.textNumAge = textNumAge;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.cake_outlined),
                                border: OutlineInputBorder(),
                                hintText: "อายุ"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                flex: 2,
                                child: TextFormField(
                                  //initialValue: " ",
                                  validator: RequiredValidator(
                                      errorText: "กรุณาป้อนน้ำหนักของท่าน"),
                                  onSaved: (String? textNumWeight) {
                                    myPatient.textNumWeight = textNumWeight;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.monitor_weight_outlined),
                                      border: OutlineInputBorder(),
                                      hintText: "น้ำหนัก(กก.)"),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: TextFormField(
                                  //initialValue: " ",
                                  validator: RequiredValidator(
                                      errorText: "กรุณาป้อนส่วนสูงของท่าน"),
                                  onSaved: (String? textNumHeight) {
                                    myPatient.textNumHeight = textNumHeight;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.height_outlined),
                                      border: OutlineInputBorder(),
                                      hintText: "ส่วนสูง(ซม.)"),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            //initialValue: " ",
                            validator: RequiredValidator(
                                errorText: "กรุณาป้อนอุณหภูมิร่างกาย"),
                            onSaved: (String? textNumTemperature) {
                              myPatient.textNumTemperature = textNumTemperature;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.thermostat_outlined),
                                border: OutlineInputBorder(),
                                hintText: "อุณหภูมิร่างกาย"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          /* Decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black, width: 4),
                          ), */
                          Container(
                              margin: EdgeInsets.all(2),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: Colors.black45, width: 1),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: gvalue,
                                  iconSize: 20,
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black54,
                                  ),
                                  isExpanded: true,
                                  items: items.map(buildMenuItem).toList(),
                                  onChanged: (gvalue) => setState(
                                    () => this.gvalue = gvalue,
                                  ),
                                ),
                              )),
                          /*  Row(
                            children: <Widget>[
                              Expanded(
                                child: FloatingActionButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('กำลังบันทึกข้อมูล'),
                                        ),
                                      );
                                      patientCollection
                                          .add({
                                            'textName': myPatient.textName,
                                            'textSurname':
                                                myPatient.textSurname,
                                            'textNumAge': myPatient.textNumAge,
                                            'textNumWeight':
                                                myPatient.textNumWeight,
                                            'textNumHeight':
                                                myPatient.textNumHeight,
                                            'textNumTemperature':
                                                myPatient.textNumTemperature,
                                          })
                                          .then((value) => print('เรียบร้อย'))
                                          .catchError((error) => print(
                                              'การบันทึกขัดข้อง: $error'));
                                      _formKey.currentState!.reset();
                                    }
                                  },
                                  child: Icon(Icons.archive_outlined),
                                ),
                              ),
                            ],
                          ) */
                        ],
                      ),
                    ),
                  )),
              bottomNavigationBar: TabbarMaterialWidget(),
              floatingActionButton: buildNavigateButton(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildNavigateButton() => FloatingActionButton(
        child: Icon(Icons.archive_outlined),
        backgroundColor: Color.fromARGB(199, 10, 81, 161),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('กำลังบันทึกข้อมูล'),
              ),
            );
            patientCollection
                .add({
                  'textName': myPatient.textName,
                  'textSurname': myPatient.textSurname,
                  'textNumAge': myPatient.textNumAge,
                  'textNumWeight': myPatient.textNumWeight,
                  'textNumHeight': myPatient.textNumHeight,
                  'textNumTemperature': myPatient.textNumTemperature,
                  'Gender': gvalue,
                })
                .then((value) => print('เรียบร้อย'))
                .catchError((error) => print('การบันทึกขัดข้อง: $error'));
            _formKey.currentState!.reset();
          }
        },
      );
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15,
              color: Colors.black87),
        ),
      );
}
