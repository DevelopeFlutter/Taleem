// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helper/constnats.dart';
import '../services/Authservices.dart';
import '../widgets/custom_textfield.dart';

class Foregetpassword extends StatefulWidget {
  const Foregetpassword({Key? key}) : super(key: key);

  @override
  State<Foregetpassword> createState() => _ForegetpasswordState();
}

class _ForegetpasswordState extends State<Foregetpassword> {
  TextEditingController email = TextEditingController();
  final bool _isloading = false;
  final _formkey = GlobalKey<FormState>();

  Future forgetlink() async {
    if (_formkey.currentState!.validate()) {
      try {
        await Authservices().forgetpass(context, email.text);
        Fluttertoast.showToast(
            msg: 'Password Resent link is sent to your Email');
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0F3460),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 60.0, left: 20, right: 20),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Taleem',
                    style: GoogleFonts.kanit(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 30)),
                const SizedBox(
                  height: 5,
                ),
                Text('Get paid course for...free!',
                    style: GoogleFonts.kanit(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 14)),
                const SizedBox(
                  height: 30,
                ),
                customtextfeild(
                    Icon(
                      Icons.email_rounded,
                      color: Constant().pinkcolor,
                    ),
                    'Enter email here',
                    email),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      forgetlink();
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 70),
                        backgroundColor: Constant().pinkcolor),
                    child: _isloading
                        ? CircularProgressIndicator()
                        : Text(
                            "Get Resent link",
                            style: TextStyle(fontSize: 20),
                          )),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
