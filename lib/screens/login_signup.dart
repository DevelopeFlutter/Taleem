// ignore_for_file: body_might_complete_normally_nullable, prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helper/constnats.dart';
import '../services/Authservices.dart';
import '../widgets/custom_textfield.dart';
import 'forgetpass.dart';

class LogIn_reg extends StatefulWidget {
  const LogIn_reg({Key? key}) : super(key: key);

  @override
  State<LogIn_reg> createState() => _LogIn_regState();
}

class _LogIn_regState extends State<LogIn_reg> {
  final _formkey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _islogin = false;
  bool _isloading = false;
  TextEditingController email = TextEditingController();
  TextEditingController email2 = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController pass2 = TextEditingController();
  Authservices authservices = Authservices();

  signinsignup() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        _isloading = true;
      });
      if (!_islogin) {
        await authservices.signn(email.text, pass.text, context);
        setState(() {
          _isloading = false;
        });
      } else {
        setState(() {
          _isloading = true;
        });
        await authservices.signup(
            email.text, fullname.text, pass.text, context);
        setState(() {
          _isloading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0F3460),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 20, right: 20),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Text('Taleem',
                      style: GoogleFonts.kanit(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 30)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('Everything for-  free!',
                      style: GoogleFonts.kanit(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 14)),
                  const SizedBox(
                    height: 30,
                  ),
                  const Image(
                    image: AssetImage('assets/images/Reg.png'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (_islogin)
                    customtextfeild(
                        Icon(
                          Icons.account_box,
                          color: Constant().pinkcolor,
                        ),
                        'Enter full name here', (value) {
                      if (value.isEmpty) {
                        Text('Please Enter Your Full name');
                      }
                    }, fullname),
                  SizedBox(
                    height: 10,
                  ),
                  customtextfeild(
                      Icon(
                        Icons.email_rounded,
                        color: Constant().pinkcolor,
                      ),
                      'Enter email here', (value) {
                    if (value.isEmpty) {
                      Text('Please Enter Your Full name');
                    }
                  }, email),
                  SizedBox(
                    height: 10,
                  ),
                  customtextfeild(
                      Icon(
                        Icons.password_outlined,
                        color: Constant().pinkcolor,
                      ),
                      'Enter password here', (value) {
                    if (value.isEmpty) {
                      Text('Please Enter Your Full name');
                    }
                  }, pass),
                  SizedBox(
                    height: 10,
                  ),
                  if (!_islogin)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => Foregetpassword()));
                          },
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(
                              color: Constant().pinkcolor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (!_islogin)
                    SizedBox(
                      height: 10,
                    ),
                  ElevatedButton(
                      onPressed: () {
                        signinsignup();
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 70),
                          backgroundColor: Constant().pinkcolor),
                      child: _isloading
                          ? CircularProgressIndicator()
                          : Text(
                              _islogin ? 'Sign Up' : "Sign In",
                              style: TextStyle(fontSize: 20),
                            )),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _islogin = !_islogin;
                        });
                      },
                      child: Text(
                        _islogin
                            ? 'Already have an account?Login'
                            : 'Create new account here.',
                        style: TextStyle(
                            color: Constant().pinkcolor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
