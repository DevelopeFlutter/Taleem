import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_hub/screens/ticketdetail.dart';
import 'package:course_hub/services/authservices.dart';
import 'package:course_hub/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helper/constnats.dart';

Widget suppportTicket(bool status, String? title, String? authorname,
    String? dicsription, String? link, context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Ticketdetail(
                    title: '$title',
                    authorname: '$authorname',
                    discription: '$dicsription',
                    link: '$link')));
      },
      child: Container(
        height: 70,
        child: Center(
          child: ListTile(
              tileColor: Colors.white,
              leading: Icon(
                Icons.support_agent_outlined,
                size: 30,
              ),
              title: Text(
                '$title',
                style: GoogleFonts.kanit(
                    fontSize: 16,
                    color: Color(0xff0F3460),
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text('$authorname',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.kanit(
                    fontSize: 12,
                    color: Color(0xff0F3460),
                  )),
              trailing: Text(
                status ? 'Done' : ' In-Progress',
                style: GoogleFonts.kanit(
                  fontSize: 12,
                  color: Color(0xff0F3460),
                ),
              )),
        ),
      ),
    ),
  );
}

class PlaceholderDialog extends StatefulWidget {
  const PlaceholderDialog({
    this.titleedit,
    this.actions = const [],
    Key? key,
  }) : super(key: key);
  final TextEditingController? titleedit;
  final List<Widget> actions;

  @override
  State<PlaceholderDialog> createState() => _PlaceholderDialogState();
}

class _PlaceholderDialogState extends State<PlaceholderDialog> {
  FirebaseFirestore fstore = FirebaseFirestore.instance;
  TextEditingController ctr = TextEditingController();
  TextEditingController authorctr = TextEditingController();
  TextEditingController dicctr = TextEditingController();
  TextEditingController doctitle = TextEditingController();
  Authservices authservice = Authservices();
  final _formkey = GlobalKey<FormState>();

  sendticket() async {
    await authservice.ticketdetail(
        context, ctr.text, authorctr.text, dicctr.text, doctitle.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        icon: Text(
          'Request Resources',
          style: GoogleFonts.kanit(fontSize: 16, color: Color(0xff0F3460)),
        ),
        // title: customtextfeildforsupport(Icon(Icons.title),
        //     'Give a Title to Ticket',  ctr, 1, 100),
        content: Form(
          key: _formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              customtextfeildforsupport(
                  Icon(Icons.title), 'Give a Title to Ticket', ctr, 1, 100),
              SizedBox(
                height: 10,
              ),
              customtextfeildforsupport(Icon(Icons.text_fields),
                  'Author Name/Course Instructor', authorctr, 1, 50),
              SizedBox(
                height: 10,
              ),
              customtextfeildforsupport(Icon(Icons.text_fields),
                  'Dicription of Book/Course/PPT', dicctr, 3, 200),
              SizedBox(
                height: 10,
              ),
              customtextfeildforsupport(
                  Icon(Icons.text_fields),
                  'Add reference link of cover page of book/course',
                  doctitle,
                  1,
                  200),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsOverflowButtonSpacing: 8.0,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: GoogleFonts.kanit(fontSize: 16, color: Color(0xff0F3460)),
            ),
          ),
          TextButton(
            onPressed: () {
              if (_formkey.currentState!.validate()) {
                sendticket();
              }
            },
            child: Text('Submit',
                style:
                    GoogleFonts.kanit(fontSize: 16, color: Color(0xff0F3460))),
          ),
        ],
      ),
    );
  }

  Widget customtextfeildforsupport(Icon icon, String httxt,
      TextEditingController ctr, int minlines, int mexlength) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        // helperText: helpertext,
        helperMaxLines: 3,
        prefixIcon: icon,

        hintText: httxt,
        hintStyle: const TextStyle(color: Color(0xff0F3460), fontSize: 12),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Constant().pinkcolor, width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Constant().pinkcolor, width: 1)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required';
        }
      },
      controller: ctr,
      minLines: minlines,
      maxLines: 5,
      maxLength: mexlength,
    );
  }
}
