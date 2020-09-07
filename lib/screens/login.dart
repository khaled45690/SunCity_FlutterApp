import 'dart:convert';
import 'dart:io';
import 'package:SunCity_FlutterApp/models/url_File.dart';
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
  String _serverUrl = URL.serverUrl;

  int _statusCode;
  String _email;
  String _password;
  bool _isLoading = false;
  bool hidepass = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  void _exceptionHandler() {
    // flutter defined function

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("لقد حدث خطأ"),
          content: ((_statusCode == null) ||
                  (_statusCode == 400) ||
                  (_statusCode == 401))
              ? new Text("برجاءالتأكد من إسم المستخدم وكلمة المرور")
              : new Text("لقد حدث خطأ برجاء الإتصال بالدعم الفني"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("إغلاق"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  logIn(String email, String password) async {
    String uri = "${_serverUrl}api/User/Login";
    setState(() {
      _isLoading = true;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var responseJson;

    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "UserName": _email,
        "password": _password,
      }),
    );

    setState(() {
      _statusCode = response.statusCode;
    });

    if (response.statusCode == 200) {
       setState(() {
      _isLoading = false;
    });

      responseJson = json.decode(response.body);
      print(responseJson);
      if (response != null) {
        sharedPreferences.setString("token", responseJson["token"]);
        print("Bearer " + sharedPreferences.getString("token"));
      }
    } else {
      setState(() {
      _isLoading = false;
    });
    }

    return response;
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
                return 'من فضلك أدخل الإيميل';
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
                return 'من فضلك أدخل كلمة المرور';
              } else if (value.length < 6) {
                return "كلمه المرور يجب الا تقل عن 6 ارقام";
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
    if (_isLoading == false) {
      return Scaffold(
          appBar: AppBar(
            title: Text("تسجيل الدخول"),
            centerTitle: true,
          ),
          body: ListView(
            children: <Widget>[
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            onPressed: () async {
                      
                              if (!_formKey.currentState.validate()) {
                                return _formKey;
                              }

                              await logIn(_email, _password);

                                   if (_statusCode == 200) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => new HomeScreen()));
                                    Navigator.of(context)
                                        .pushNamed(HomeScreen.routeName);
                                  } else {
                                    _exceptionHandler();
                                  }
                            }),
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
              },
              child: Text(
                'ليس لدي حساب',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),
          )));
    } else {
      return Container(
        color: Colors.white,
        child: Center(child: CircularProgressIndicator()),
      );
    }
  }
}
