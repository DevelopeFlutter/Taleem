// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_hub/helper/Adids.dart';

import 'package:course_hub/screens/Homepage.dart';
import 'package:course_hub/screens/bookhome.dart';
import 'package:course_hub/screens/pptscreen.dart';
import 'package:course_hub/screens/support.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../helper/helper.dart';
import '../model/usermodel.dart';
import 'drawer.dart';

class Gotohome extends StatefulWidget {
  const Gotohome({Key? key}) : super(key: key);

  @override
  State<Gotohome> createState() => _GotohomeState();
}

class _GotohomeState extends State<Gotohome> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  FirebaseFirestore fstore = FirebaseFirestore.instance;
  String? name;
  String? email;
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

  InterstitialAd? interstitialAd;
  bool loading = false;
  BannerAd? bannerad;
  bool addloadd = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    InterstitialAd.load(
        adUnitId: InterstitialID3,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: ((ad) {
              setState(() {
                loading = true;
                this.interstitialAd = ad;
              });
            }),
            onAdFailedToLoad: ((error) {})));
    bannerad = BannerAd(
        size: AdSize.banner,
        adUnitId: BannerID4,
        listener: BannerAdListener(onAdLoaded: (ad) {
          setState(() {
            addloadd = true;
          });
        }, onAdFailedToLoad: ((ad, error) {
          ad.dispose();
        })),
        request: AdRequest());
    bannerad!.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        backgroundColor: Color(0xff0F3460),
        drawer: drawer(context),
        body: Column(children: [
          Container(
            height: screenheight(context) / 3,
            decoration: BoxDecoration(
              color: Color(0xffE94560),
              backgroundBlendMode: BlendMode.darken,
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(30.0)),
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/home_bg.jpg',
                  ),
                  fit: BoxFit.cover),
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 5.0,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                InkWell(
                    child: Icon(Icons.menu, size: 30, color: Color(0xffE94560)),
                    onTap: () {
                      _scaffoldkey.currentState?.openDrawer();
                    }),
                Spacer(),
                Text(
                  'Taleem',
                  style: GoogleFonts.kanit(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                      color: Color(0xffE94560)),
                ),
                Spacer(),
                CircleAvatar(
                  backgroundColor: Color(0xffE94560),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Select What You Need',
                    style: GoogleFonts.kanit(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700)),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 20,
                      width: screenwidth(context) * .05,
                    ),
                    InkWell(
                      onTap: () {
                        if (loading) {
                          interstitialAd!.show();
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => HomeScreenbook()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.pinkAccent[200],
                            borderRadius: BorderRadius.circular(10)),
                        height: 80,
                        width: screenwidth(context) * .4,
                        child: Center(
                            child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Books',
                                style: GoogleFonts.kanit(
                                    color: Color(0xff0F3460),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Spacer(),
                            Image(
                              image: AssetImage(
                                'assets/images/book.png',
                              ),
                              width: 60,
                            )
                          ],
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      width: screenwidth(context) * .1,
                    ),
                    InkWell(
                      onTap: () {
                        if (loading) {
                          interstitialAd!.show();
                        }
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => HomeScreenPPT()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.pinkAccent[200],
                            borderRadius: BorderRadius.circular(10)),
                        height: 80,
                        width: screenwidth(context) * .4,
                        child: Center(
                            child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'PPT',
                                style: GoogleFonts.kanit(
                                    color: Color(0xff0F3460),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Spacer(),
                            Image(
                              image: AssetImage(
                                'assets/images/ppt.png',
                              ),
                              width: 40,
                            ),
                            SizedBox(
                              width: 5,
                            )
                          ],
                        )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    if (loading) {
                      interstitialAd!.show();
                    }
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => HomeScreen()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.pinkAccent[200],
                        borderRadius: BorderRadius.circular(10)),
                    height: 100,
                    width: screenwidth(context) * .9,
                    child: Center(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Udemy Courses',
                              style: GoogleFonts.kanit(
                                  color: Color(0xff0F3460),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Spacer(),
                          Image(
                            image: AssetImage(
                              'assets/images/course.png',
                            ),
                            width: 60,
                          ),
                          SizedBox(
                            width: 5,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                            height: 20,
                          ),
                InkWell(
                  onTap: () {
                    if (loading) {
                      interstitialAd!.show();
                    }
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SupportTicket()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.pinkAccent[200],
                        borderRadius: BorderRadius.circular(10)),
                    height: 100,
                    width: screenwidth(context) * .9,
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Support',
                              style: GoogleFonts.kanit(
                                  color: Color(0xff0F3460),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  'You need something not here yet. Click here',
                                  style: GoogleFonts.kanit(
                                      color: Color(0xff0F3460),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700),
                                ),
                            ],
                          ),
                          SizedBox(
                            width: 5,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}
