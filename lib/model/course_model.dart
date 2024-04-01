import 'package:flutter/material.dart';

class Coursemodel {
  String? coursename;
  String? tutorname;
  String? category;
  String? about;
  String? demolink;
  String? downloadlink;
  String? sendername;

  Coursemodel(
      {this.coursename,
      this.tutorname,
      this.category,
      this.about,
      this.demolink,
      this.downloadlink,
      this.sendername,
      });

  factory Coursemodel.fromMap(map) {
    return Coursemodel(
        coursename: map['coursename'],
        tutorname: map['tutorname'],
        category: map['category'],
        about: map['about'],
        demolink: map['demolink'],
        downloadlink: map['downloadlink'],
        sendername: map['sednername']);
  }

  Map<String, dynamic> toMap() {
    return {
      'coursename': coursename,
      'tutorname': tutorname,
      'category': category,
      'about': about,
      'demolink': demolink,
      'downloadlink': downloadlink,
      'sendername' : sendername
    };
  }
}

class Bookmodel {
  String? bookname;
  String? tutorname;
  String? category;
  String? about;
  String? demolink;
  String? downloadlink;
  String? sendername;

  Bookmodel(
      {this.bookname,
      this.tutorname,
      this.category,
      this.about,
      this.demolink,
      this.downloadlink,
      this.sendername});

  factory Bookmodel.fromMap(map) {
    return Bookmodel(
        bookname: map['bookname'],
        tutorname: map['tutorname'],
        category: map['category'],
        about: map['about'],
        demolink: map['demolink'],
        downloadlink: map['downloadlink'],
        sendername:  map['sendername']);
  }

  Map<String, dynamic> toMap() {
    return {
      'bookname': bookname,
      'tutorname': tutorname,
      'category': category,
      'about': about,
      'demolink': demolink,
      'downloadlink': downloadlink,
      'sendername' : sendername
    };
  }
}

class PPTmodel {
  String? pptname;
  String? tutorname;
  String? category;
  String? demolink;
  String? downloadlink;
  String? sendername;

  PPTmodel(
      {this.pptname,
      this.tutorname,
      this.category,
      this.demolink,
      this.downloadlink,
      this.sendername});

  factory PPTmodel.fromMap(map) {
    return PPTmodel(
        pptname: map['pptname'],
        tutorname: map['tutorname'],
        category: map['category'],
        demolink: map['demolink'],
        downloadlink: map['downloadlink'],
        sendername:  map['sendername']);
  }

  Map<String, dynamic> toMap() {
    return {
      'pptname': pptname,
      'tutorname': tutorname,
      'category': category,
      'demolink': demolink,
      'downloadlink': downloadlink,
      'sendername' : sendername
    };
  }
}

class Ticketmodel {
  String? title;
  String? author;
  String? dicription;
  String? doctitle;


  Ticketmodel(
      {this.title,
      this.author,
      this.dicription,
      this.doctitle});

  factory Ticketmodel.fromMap(map) {
    return Ticketmodel(
        title: map['title'],
        author: map['author'],
        dicription: map['dicripton'],
        doctitle: map['doctitle']
       );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'dicription': dicription,
      'doctitle': doctitle,
    };
  }
}

class Donatemodel {
  String? booktitle;
  String? authorname;
  String? coverlink;
  String?  booklink;
  String? yournmae;


  Donatemodel(
      {this.booktitle,
      this.authorname,
      this.coverlink,
      this.booklink,
      this.yournmae});

  factory Donatemodel.fromMap(map) {
    return Donatemodel(
        booktitle: map['booktitle'],
        authorname: map['authorname'],
        coverlink: map['coverlink'],
        booklink: map['booklink'],
        yournmae: map['yournmae']
       );
  }

  Map<String, dynamic> toMap() {
    return {
      'booktitle': booktitle,
      'authorname': authorname,
      'coverlink': coverlink,
      'booklink': booklink,
      'yournmae' : yournmae
    };
  }
}
