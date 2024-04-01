import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_hub/model/course_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/usermodel.dart';

class Databaseservices {
  String? uid;
  Databaseservices({this.uid});
  FirebaseFirestore fstore = FirebaseFirestore.instance;

  final CollectionReference usercollection =
      FirebaseFirestore.instance.collection('User');
  final CollectionReference coursecollection =
      FirebaseFirestore.instance.collection('Courses');
      final CollectionReference ticketcollection =
      FirebaseFirestore.instance.collection('Ticket');
      final CollectionReference donatcollection =
      FirebaseFirestore.instance.collection('Donate');

  Future postdetailtofirestore(
    String fullnme,
  ) async {
    User? user = FirebaseAuth.instance.currentUser;
    Usermodel usermodel = Usermodel();

    usermodel.email = user!.email;
    usermodel.fullname = fullnme;
    usermodel.uid = user.uid;
    await usercollection.doc(uid).set(usermodel.toMap());
  }
  Future postticketdetailtofirestore(
    String title,
    String author,
    String dicription,
    String doctitle,
  ) async {
    User? user = FirebaseAuth.instance.currentUser;
    Ticketmodel ticketmodel = Ticketmodel();

    ticketmodel.title = title;
    ticketmodel.author = author;
    ticketmodel.dicription = dicription;
    ticketmodel.doctitle = doctitle;
    await ticketcollection.doc(uid).set(ticketmodel.toMap());
  }

   Future postbookdetailtofirestoreforadmin(
    String booktitle,
    String authorname,
    String coverlink,
    String booklink,
    String yournmae
  ) async {
    User? user = FirebaseAuth.instance.currentUser;
    Donatemodel donatemodel = Donatemodel();

    donatemodel.booktitle = booktitle;
    donatemodel.authorname = authorname;
    donatemodel.coverlink = coverlink;
    donatemodel.booklink = booklink;
    donatemodel.yournmae = yournmae;

    await donatcollection.doc(uid).set(donatemodel.toMap());
  }
}
