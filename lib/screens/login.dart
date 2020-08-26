import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
//import 'home.dart';
import 'signup.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  static const routeName = '/Login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email;
  String _password;
  bool _isLoading = false;
  bool hidepass = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  logIn(String email, String password) async {
    // String uri = "http://192.168.1.27:3001/api/1";
    String uri = "http://algosys-001-site16.ctempurl.com/api/User/Login";
    // String uri = "http://192.168.1.27:3001/api/1";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var responseJson;
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "UserName": email,
        "password": password,
      }),
    );
    if (response.statusCode == 200) {
      responseJson = json.decode(response.body);
      print(responseJson);
      if (responseJson != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("token", responseJson["token"]);
        print("Bearer " + sharedPreferences.getString("token"));
      }
    } else {
      setState(() {
        _isLoading = false;
      });

      print(responseJson.body);
    }
  }

  Widget _buildEmail() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: TextFormField(
            decoration: InputDecoration(
                labelText: 'الإيميل',
                icon: IconButton(
                  icon: Icon(
                    Icons.email,
                    // color: Colors.blue,
                  ),
                  onPressed: () {},
                ),
                labelStyle: TextStyle(fontSize: 25)),
            validator: (String value) {
              if (value.isEmpty) {
                return 'أدخل كلمة المرور';
              }

              if (!RegExp(
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                  .hasMatch(value)) {
                return 'من فضلك أدخل الإيميل بالشكل الصحيح';
              }
              // return "kk";
            },
            onChanged: (String value) {
              _email = value;
            },
          ),
        ));
  }

  Widget _buildPassworld() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: TextFormField(
            obscureText: hidepass,
            decoration: InputDecoration(
                labelText: 'كلمة المرور',
                //  icon: IconButton(
                //   icon: Icon(Icons.visibility_off), onPressed: (){},),

                labelStyle: TextStyle(fontSize: 25)),
            keyboardType: TextInputType.visiblePassword,
            validator: (String value) {
              if (value.isEmpty) {
                return 'من فضلك ادخل كلمه';
              } else if (value.length < 8) {
                return "كلمه المرور يجب الا تقل عن 8 ارقام";
              }
              // return "";
            },
            onChanged: (String value) {
              _password = value;
            },
          ),
          leading: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                //color: Colors.blue,
              ),
              onPressed: () {
                setState(() {
                  hidepass = !hidepass;
                });
              }),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.blue,
          title: Text("تسجيل الدخول"),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            //  Image.asset('images/products/omar.jpg',fit:BoxFit.cover, width: double.infinity),

            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                margin: EdgeInsets.all(25),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildEmail(),
                      _buildPassworld(),
                      Divider(),
                      SizedBox(height: 20),
                      RaisedButton(
                        color: Colors.grey,
                        child: Text(
                          'تسجيل الدخول',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                          });
                          if (!_formKey.currentState.validate()) {
                            return;
                          }

                          logIn(_email, _password);
                          _formKey.currentState.save();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new HomeScreen()));
                          Navigator.of(context).pushNamed(HomeScreen.routeName);
                        },
                      ),
                      // FlatButton(
                      //   child: Text(
                      //     "نسيت كلمة المرور",
                      //     style: TextStyle(
                      //         fontSize: 20, fontWeight: FontWeight.bold),
                      //   ),
                      //   onPressed: () {
                      //     _handlePressed();
                      //   },
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
            child: Padding(
          padding:
              const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
          child: FlatButton(
            color: Colors.grey,
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(SignUp.routeName);
            },
            child: Text(
              'ليس لدي حساب',
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
          ),
        )));
  }
}
