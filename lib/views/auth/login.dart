import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsm/models/user_model.dart';
import 'package:fsm/services/api_service.dart';
import 'package:fsm/theme.dart';
import 'package:fsm/views/home_layout.dart';
import 'package:hive/hive.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _validate = false;
  bool _validatePassword = false;
  Box userBox;

  @override
  void initState() {
    super.initState();
    userBox = Hive.box('userBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: Builder(builder: (context) {
        return Center(
          child: Container(
            width: 300,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                      'images/006-female-student.png',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 38, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Welcome',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 40),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: drawbackgroundColor,
                      disabledBorder: InputBorder.none,
                      hintText: 'Email or Username',
                      errorText: _validate ? 'Username Can\'t Be Empty' : null,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0, color: Colors.white),
                          borderRadius: BorderRadius.circular(30)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 0, color: Colors.white),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextField(
                    controller: _pinController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: drawbackgroundColor,
                      hintText: 'Password',
                      errorText:
                          _validatePassword ? 'Password Can\'t Be Empty' : null,
                      disabledBorder: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0, color: Colors.white),
                          borderRadius: BorderRadius.circular(30)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 0, color: Colors.white),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                  SizedBox(height: 20),
                  FlatButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        setState(() {
                          _pinController.text.isEmpty
                              ? _validatePassword = true
                              : _validatePassword = false;
                          _emailController.text.isEmpty
                              ? _validate = true
                              : _validate = false;
                        });
                        if (_pinController.text.isNotEmpty &&
                            _emailController.text.isNotEmpty) {
                          _showSnackBar(context);
                        }
                      }),
                ]),
          ),
        );
      }),
    );
  }

  Future<void> _showSnackBar(BuildContext context) async {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Container(
        height: 50.0,
        child: Center(
          child: Text(
            'Processing...',
            style: const TextStyle(fontSize: 25.0),
          ),
        ),
      ),
      backgroundColor: listTileSelectedTextStyle.color,
    );
    bool processing = true;
    if (processing) {
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
    var user = {
      "email": _emailController.text,
      "password": _pinController.text
    };
    var message = await loginUser(user);
    var body = jsonDecode(message.body.toString());

    String token = body;
    if (message.statusCode == 200)
      userBox.putAll({'token': token.replaceAll('"', ' ')});

    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeLayout(),
      ),
    );

    final errorBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Container(
        height: 50.0,
        child: Center(
          child: Text(
            '${body['message']}: ${body['errors']}',
            style: const TextStyle(fontSize: 25.0),
          ),
        ),
      ),
      backgroundColor: Colors.red,
    );
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(errorBar);
  }
}
