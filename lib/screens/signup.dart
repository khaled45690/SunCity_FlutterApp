import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/RoundedImageWidget.dart';
import 'login.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

File _imageFile;

class SignUp extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  upload(String imageFile) async {
    String url = "http://algosys-001-site16.ctempurl.com/api/Admin/SaveImage";
    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.files.add(await http.MultipartFile.fromPath('picture', imageFile));
    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    print(respStr);
  }

  String _name;
  String _email;
  String _password;
  String _url;
  String _phoneNumber;
  String _confirmPassword;

  submitForm(String name, String email, String phoneNumber, String password,
      String confirmPassword, File image) async {
    // String uri = "http://192.168.1.27:3001/api/1";
    String uri =
        "http://algosys-001-site16.ctempurl.com/api/Client/Registration";
    // String uri = "http://192.168.1.27:3001/api/1";

    String photo = image != null
        ? 'data:image/jpg;base64' + base64Encode(image.readAsBytesSync())
        : '';

    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "UserName": name,
        "Email": email,
        "Mobile": phoneNumber,
        "profileImage": null,
        "Password": password,
        "ConfirmPassword": confirmPassword,
      }),
    );

    final responseJson = json.decode(response.body);

    print(responseJson);
  }

  String groupValue = "male";
  bool hidePass = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();

  Widget _buildUserName() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: TextFormField(
            decoration: InputDecoration(
              hintText: 'إسم المستخدم ',
              icon: Icon(Icons.person),
            ),
            // validator: (String value) {
            //   if (value.isEmpty) {
            //     return 'من فضلك أدخل رقم المويايل';
            //   } else if (value.length < 14) {
            //     return "من فضلك أدخل 11 رقم";
            //   }
            //   return "";
            // },
            onChanged: (String value) {
              _name = value;
            },
          ),
        ));
  }

  Widget _buildEmail() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: TextFormField(
            decoration: InputDecoration(
              hintText: 'الإيميل',
              icon: Icon(Icons.email),
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return 'من فضلك أدخل الإيميل';
              }

              if (!RegExp(
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                  .hasMatch(value)) {
                return 'من فضلك أدخل الإيميل بالشكل الصحيح';
              }
              return null;
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
            controller: _passwordTextController,
            obscureText: hidePass,
            decoration: InputDecoration(
              hintText: 'كلمة المرور',
              icon: Icon(Icons.lock_outline),
              //  border: InputBorder.none
            ),
            keyboardType: TextInputType.visiblePassword,
            validator: (String value) {
              if (value.isEmpty) {
                return 'من فضلك أدخل كلمة المرور';
              } else if (value.length < 6) {
                return "كلمه المرور يجب الا تقل عن 6 ارقام";
              }
              return "";
            },
            onChanged: (String value) {
              _password = value;
            },
          ),
          trailing: IconButton(
              icon: Icon(Icons.remove_red_eye),
              onPressed: () {
                setState(() {
                  hidePass = !hidePass;
                });
              }),
        ));
  }

  Widget _buildPhoto() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 4, 45, 4),
          child: FlatButton(
            color: Colors.blue,
            onPressed: () {
              //    getImage(false);
            },
            child: Text('gallery'),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneNumber() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: TextFormField(
            decoration: InputDecoration(
              hintText: 'رقم الموبايل',
              icon: Icon(Icons.phone),
            ),
            // validator: (String value) {
            //   if (value.isEmpty) {
            //     return 'من فضلك أدخل رقم المويايل';
            //   } else if (value.length < 14) {
            //     return "من فضلك أدخل 11 رقم";
            //   }
            //   return "";
            // },
            onChanged: (String value) {
              _phoneNumber = value;
            },
          ),
        ));
  }

  Widget _buildConfirmPassword() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: TextFormField(
            controller: _confirmPasswordController,
            obscureText: hidePass,
            decoration: InputDecoration(
              hintText: 'تأكيد كلمة المرور',
              icon: Icon(Icons.lock_outline),
            ),
            keyboardType: TextInputType.visiblePassword,
            validator: (String value) {
              if (value.isEmpty) {
                return 'تأكيد كلمة المرور';
              } else if (value.length < 6) {
                return "كلمه المرور يجب الا تقل عن 6 ارقام";
              } else if (_confirmPasswordController.text !=
                  _passwordTextController.text) {
                return ("كلمة المرور غير متطابقه");
              }
              return "";
            },
            onChanged: (String value) {
              _confirmPassword = value;
            },
          ),
          trailing: IconButton(
              icon: Icon(Icons.remove_red_eye),
              onPressed: () {
                setState(() {
                  hidePass = !hidePass;
                });
              }),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('التسجيل'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(40),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildUserName(),
                  SizedBox(height: 20.0),
                  _buildEmail(),
                  SizedBox(height: 20.0),
                  _buildPhoneNumber(),
                  SizedBox(height: 20.0),
                  _buildPassworld(),
                  SizedBox(height: 20.0),
                  _buildConfirmPassword(),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                          color: Colors.grey,
                          onPressed: () async {
                            final picked = await ImagePicker.pickImage(
                                source: ImageSource.gallery);
                            upload(picked.path);
                            setState(() {
                              _imageFile = picked;
                            });
                            print(picked);
                          },
                          child: Text("رفع صوره")),
                      RoundedImageWidget(
                        imagefile: _imageFile,
                      ),
                    ],
                  ),
                  Divider(),
                  SizedBox(height: 20),
                  RaisedButton(
                    child: Text(
                      'التسجيل',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                    onPressed: () {
                      submitForm(_name, _email, _phoneNumber, _password,
                          _confirmPassword, _imageFile);
                    },
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(40),
                        child: InkWell(
                          child: new Text(
                            "لدي حساب بالفعل",
                            style: TextStyle(
                                color: Colors.red.shade900,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed(Login.routeName);
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void validateForm() {
    FormState formState = _formKey.currentState;
    if (formState.validate()) {
//      Navigator.of(context).pushNamed(Login.routeName);
    }
  }
}
