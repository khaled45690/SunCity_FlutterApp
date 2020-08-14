import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/RoundedImageWidget.dart';
import 'login.dart';
import 'dart:io';
import 'dart:async';

File _imageFile;

class SignUp extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Future <File> imageFile;

  // pickImageFromGallery(ImageSource source){
  //   setState(() {
  //         imageFile = ImagePicker.pickImage(source: source);

  //   });
  // }

  // Widget showImage(){
  //   return FutureBuilder<File>(
  //     future: imageFile,
  //     builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done && snapshot.data !=null){
  //         return Image.file(
  //           snapshot.data,
  //           width:300,
  //           height:300
  //         );
  //       }else if(snapshot.error != null){
  //         return const Text(
  //           'Error picking Image',
  //           textAlign: TextAlign.center
  //         );
  //       }else{
  //         return const Text(
  //           'No image Selected',
  //           textAlign:  TextAlign.center
  //         );
  //       }
  //     },
  //   );
  // }

  // Future getImage(bool isCamera) async {
  //   File image;
  //     if (isCamera){
  //       image = await ImagePicker.pickImage(source: ImageSource.camera);
  //     }else{
  //       image =await ImagePicker.pickImage(source: ImageSource.gallery);
  //     }
  //   setState(() {
  //       _image = image;

  //     });

  //   }

  String _name;
  String _email;
  String _passworld;
  String _url;
  String _phoneNumber;
  String _confirmpassword;

  String groupvalue = "male";
  bool hidepass = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmPassworldController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();

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
            controller: _passwordTextController,
            obscureText: hidepass,
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
                return"كلمه المرور يجب الا تقل عن 6 ارقام";
              }
              return "";
            },
            onSaved: (String value) {
              _passworld = value;
            },
          ),
          trailing: IconButton(
              icon: Icon(Icons.remove_red_eye),
              onPressed: () {
                setState(() {
                  hidepass = !hidepass;
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
        //       Divider(),
        //         Padding(
        //           padding: const EdgeInsets.fromLTRB(1,4,45,4),
        //           child: FlatButton(color:Colors.blue,
        //       onPressed: (){
        //  //         getImage(true);
        //       },
        //       child: Text('Camera'),
        //       ),
        //         ),
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
            validator: (String value) {
              if (value.isEmpty) {
                return 'من فضلك أدخل رقم المويايل';
              } else if (value.length < 14) {
                return "من فضلك أدخل 11 رقم";
              }
              return "";
            },
            onSaved: (String value) {
              _phoneNumber = value;
            },
          ),
        ));
  }

  Widget _buildconfirmPassworld() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: TextFormField(
            controller: _confirmPassworldController,
            obscureText: hidepass,
            decoration: InputDecoration(
              hintText: 'تأكيد كلمة المرور',
              icon: Icon(Icons.lock_outline),
            ),
            keyboardType: TextInputType.visiblePassword,
            validator: (String value) {
              if (value.isEmpty) {
                return 'تأكيد كلمة المرور';
              } else if (value.length < 6) {
                return"كلمه المرور يجب الا تقل عن 6 ارقام";
              } else if (_confirmPassworldController.text !=
                  _passwordTextController.text) {
                return ("كلمة المرور غير متطابقه");
              }
              return "";
            },
            onSaved: (String value) {
              _passworld = value;
            },
          ),
          trailing: IconButton(
              icon: Icon(Icons.remove_red_eye),
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
        title: Text('التسجيل'),
      ),
      body: ListView(
        children: <Widget>[
          //    _image ==null? Container() : Image.file(_image, height: 300.0, width:300.0),
          Container(
            margin: EdgeInsets.all(40),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildEmail(),
                  SizedBox(height: 20.0),

                  _buildPassworld(),
                  SizedBox(height: 20.0),

                  _buildconfirmPassworld(),
                  SizedBox(height: 20.0),

                  _buildPhoneNumber(),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                          color: Colors.grey,
                          onPressed: () async {
                            final picked = await ImagePicker.pickImage(
                                source: ImageSource.gallery);
                            setState(() {
                              _imageFile = picked;
                            });
                          },
                          child: Text("رفع صوره")),
                      RoundedImageWidget(imagefile:  _imageFile,),
                    ],
                  ),
                  // self made image widget,
                  //  _buildPhoto(),
                  Divider(),

                  SizedBox(height: 20),
                  RaisedButton(
                    child: Text(
                      'التسجيل',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                    onPressed: () {
                      validateForm();
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
      Navigator.of(context).pushNamed(Login.routeName);
    }
  }
}

