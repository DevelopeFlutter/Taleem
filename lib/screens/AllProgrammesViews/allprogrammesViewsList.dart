// ignore_for_file: prefer_const_constructors, unnecessary_import, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_hub/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../helper/Adids.dart';
import '../../helper/helper.dart';
import '../../model/usermodel.dart';

class AllProgrammesList extends StatefulWidget {
  const AllProgrammesList({super.key});
  @override
  State<AllProgrammesList> createState() => _AllProgrammesListState();
}

class _AllProgrammesListState extends State<AllProgrammesList> {
  TextEditingController controller = TextEditingController();
  FirebaseFirestore fstore = FirebaseFirestore.instance;
  String? name;
  String? email;
  bool hasusersearched = false;
  bool loading = false;
  BannerAd? bannerad;
  bool addloadd = false;
  bool bookloading = false;
  void loadBannerAd() {
    bannerad = BannerAd(
        size: AdSize.banner,
        adUnitId: BannerID3,
        listener: BannerAdListener(onAdLoaded: (ad) {
          setState(() {
            addloadd = true;
          });
          // bannerad!.load();
        }, onAdFailedToLoad: ((ad, error) {
          ad.dispose();
        })),
        request: AdRequest());
    bannerad!.load();
  }

  @override
  void initState() {
    getuserdata();
    loadBannerAd();
    super.initState();
  }

  getuserdata() async {
    await fstore
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      final usermodl = Usermodel.fromMap(value.data());
      setState(() {
        name = usermodl.fullname;
        email = usermodl.email;
      });
    });
  }

  List programmesNamesList = [
    'Computer Science',
    'Medical',
    'Business Administration',
    'Fashion Design',
    "Nutrition & Dietetics",
    'Media Studies',
    'Aviation Management',
    'Islamic Books',
    'Mathematics',
    'Physics',
    'Chemistry',
    
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff0F3460),
        body: SafeArea(
            child: Stack(children: [
          Column(
            children: [
              Container(
                height: screenheight(context) / 6,
                decoration: BoxDecoration(
                  color: Color(0xffE94560),
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 5.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Row(
                  children: [
                    GestureDetector(
                        child: Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Color(0xffF8F8F8),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                    Spacer(),
                    Text(
                      'All Programmes Books Here',
                      style: GoogleFonts.kanit(
                          fontSize: mheight * 17 / mheight,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                          color: Colors.white),
                    ),
                    Spacer(),
                    CircleAvatar(
                      backgroundColor: Color(0xffF8F8F8),
                    )
                  ],
                ),
                Text(
                  'Hi!$name',
                  style: TextStyle(
                      color: Color(0xffF8F8F8),
                      fontSize: 25,
                      fontWeight: FontWeight.w400),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    height: screenheight(context) / 13,
                    width: screenwidth(context) / .9,
                    decoration: BoxDecoration(
                      color: Color(0xffF8F8F8),
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                          bottom: Radius.circular(10.0)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                          controller: controller,
                          style: TextStyle(fontSize: 20, color: Colors.black),
                          mouseCursor: MouseCursor.uncontrolled,
                          onChanged: (val) {
                            // searchMethod(val);
                          },
                          onTap: () {},
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: 15, top: 10),
                              suffixIcon: InkWell(
                                child: hasusersearched
                                    ? Icon(
                                        Icons.cancel_outlined,
                                        color: Colors.pink,
                                      )
                                    : Icon(
                                        Icons.search,
                                        color: Colors.purple,
                                        size: 30,
                                      ),
                                onTap: () {
                                  setState(() {
                                    hasusersearched = false;
                                    controller.clear();
                                    FocusScope.of(context).unfocus();
                                  });
                                },
                              ),
                              hintText: 'Search Programmes Here',
                              hintStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400),
                              border: InputBorder.none),
                        )),
                      ],
                    ),
                  ),
                ),
                // addloadd
                //     ?
                SizedBox(
                  height: mheight * 80 / mheight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AdWidget(ad: bannerad!),
                  ),
                ),
                // : Container(),
                SizedBox(
                  height: mheight * 480 / mheight,
                  child: Expanded(
                    child: ListView.builder(
                        // physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: programmesNamesList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              //  Navigator.push(context,
                              //                         MaterialPageRoute(builder: (_) => ));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.pinkAccent[200],
                                      borderRadius: BorderRadius.circular(10)),
                                  height: mheight * 60 / mheight,
                                  width: mwidth * 200 / mwidth,
                                  child: Center(
                                      child: Text(
                                    programmesNamesList[index],
                                    style: GoogleFonts.kanit(
                                        color: Color(0xff0F3460),
                                        fontSize: mheight * 20 / mheight,
                                        fontWeight: FontWeight.w700),
                                  )),
                                ),
                                SizedBox(height: mheight * 10 / mheight),
                              ],
                            ),
                          );
                        }),
                  ),
                )
              ]))
        ])));
  }
}
