import 'package:SunCity_FlutterApp/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';

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
  String _passworld;
  bool hidepass = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                    color: Colors.blue,
                  ),
                  onPressed: () {},
                ),
                labelStyle: TextStyle(fontSize: 25, color: Colors.blue)),
            validator: (String value) {
              if (value.isEmpty) {
                return 'أدخل كلمة المرور';
              }

              if (!RegExp(
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                  .hasMatch(value)) {
                return 'من فضلك أدخل الإيميل بالشكل الصحيح';
              }
              return "kk";
            },
            onSaved: (String value) {
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

                labelStyle: TextStyle(fontSize: 25, color: Colors.blue)),
            keyboardType: TextInputType.visiblePassword,
            validator: (String value) {
              if (value.isEmpty) {
                return 'من فضلك ادخل كلمه';
              } else if (value.length < 6) {
                return "كلمه المرور يجب الا تقل عن 6 ارقام";
              }
              return "";
            },
            onSaved: (String value) {
              _passworld = value;
            },
          ),
          leading: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: Colors.blue,
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
          backgroundColor: Colors.blue,
          title: Text("تسجيل الدخول"),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            //    Image.asset('images/products/omar.jpg',fit:BoxFit.cover, width: double.infinity),

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
                        color: Colors.blue,
                        child: Text(
                          'تسجيل الدخول',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        onPressed: () {
                          if (!_formKey.currentState.validate()) {
                            return;
                          }
                          _formKey.currentState.save();
                          // Navigator.push(
                          //       context,
                          //         MaterialPageRoute(
                          //           builder: (context) => new HomeScreen()));
                          Navigator.of(context).pushNamed(HomeScreen.routeName);
                        },
                      ),
                      FlatButton(
                        child: Text(
                          "نسيت كلمة المرور",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          _handlePressed();
                        },
                      )
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
            color: Colors.blue,
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(SignUp.routeName);
            },
            child: Text(
              'ليس لدي حساب',
              style: TextStyle(fontSize: 22),
            ),
          ),
        )));
  }

  void _handlePressed() {
    confirmDialog1(context).then((bool value) {
      print("value is $value");
    });
  }
}

Future<bool> confirmDialog1(BuildContext context) {
  return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('إسترجاع كلمة المرور'),
          actions: <Widget>[
            new FlatButton(
              child: const Text("yes"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            new FlatButton(
              child: const Text("no"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            )
          ],
        );
      });
}
