// ignore_for_file: file_names, body_might_complete_normally_nullable, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_hub/screens/categoryscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helper/helper.dart';
// import '../screens/Homepage.dart';
import '../screens/login_signup.dart';
import 'databaseservices.dart';

class Authservices {
  FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential? userCredential;

  Future signup(
      String email, String fullname, String pass, BuildContext context) async {
    try {
      userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: pass)
          .then((value) {
        Databaseservices(uid: FirebaseAuth.instance.currentUser!.uid)
            .postdetailtofirestore(fullname);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const Gotohome()),
            (route) => false);
      }).catchError((e) {
        print('$e This is the e ');
        if (e is FirebaseAuthException) {
          print('$e Exception');
          if (e.toString() ==
              '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
            showsnackar(context, e.code);
          } else if (e.toString() ==
              '[firebase_auth/invalid-email] The email address is badly formatted.') {
            showsnackar(context, e.code);
          } else if (e.code == 'network-request-failed') {
            showsnackar(context, e.code);
          }
        }
        print(e.toString());
        return null;
      });
    } catch (e) {
      showsnackar(context, e.toString());
    }
  }

  Future signn(String email, String pass, BuildContext context)async {
    try {
      userCredential = await auth.signInWithEmailAndPassword(email: email, password: pass).then((value) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const Gotohome()),
            (route) => false);
      }).catchError((e) {
        if (e is FirebaseAuthException){
          print('${e.code}: Message');
          if (e.code == 'user-not-found') {
            showsnackar(context, e.code);
          } else if (e.code == 'too-many-requests'){
            showsnackar(context, e.toString());
          } else if (e.code == 'network-request-failed') {
            showsnackar(context, e.toString());
          }
        }
      });
    } catch (e) {
      print('$e this is the error ');
      showsnackar(context, e.toString());
    }
  }

  //signout
  Future signout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LogIn_reg()), (route) => false);
  }

  Future forgetpass(BuildContext context, String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const LogIn_reg()),
    );
  }

  Future ticketdetail(BuildContext context, String title, String author,
      String dicription, String doctitle) async {
    try {
      String result = DateFormat('yyyy-MM-dd H:m:s').format(DateTime.now());
      await Databaseservices(uid: result.toString())
          .postticketdetailtofirestore(
        title,
        author,
        dicription,
        doctitle,
      );
    } catch (e) {
      showsnackar(context, e.toString());
    }
  }

  donationdetail(BuildContext context, String booktitle, String authorname,
      String coverlink, String booklink, String yourname) async {
    try {
      String result = DateFormat('yyyy-MM-dd H:m:s').format(DateTime.now());
      await Databaseservices(uid: result.toString())
          .postbookdetailtofirestoreforadmin(
              booktitle, authorname, coverlink, booklink, yourname);
    } catch (e) {
      showsnackar(context, e.toString());
    }
  }
}
