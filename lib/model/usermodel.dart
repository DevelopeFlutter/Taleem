class Usermodel {
  String? fullname;
  String? email;
  String? uid;

  Usermodel(
      {this.email,
      this.fullname,
      this.uid,});

  factory Usermodel.fromMap(map) {
    return Usermodel(
        email: map['email'],
        uid: map['uid'],
        fullname: map['fullname'],);
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'uid': uid,
      'fullname': fullname,
    };
  }
}
