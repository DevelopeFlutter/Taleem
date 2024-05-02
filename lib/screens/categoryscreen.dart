// ignore_for_file: prefer_const_constructors, unnecessary_this

import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_hub/helper/Adids.dart';
import 'package:course_hub/main.dart';
import 'package:course_hub/screens/AllProgrammesViews/allprogrammesViewsList.dart';

import 'package:course_hub/screens/udemycourses.dart';
import 'package:course_hub/screens/allBooksViewScreen.dart';
import 'package:course_hub/screens/pptscreen.dart';
import 'package:course_hub/screens/support.dart';
import 'package:course_hub/widgets/bookscategoriescontainer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/single_child_widget.dart';

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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        // height: 20,
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
                                    builder: (_) => AllBooksView(
                                          collectionName: 'Books',
                                        )));
                          },
                          child: CategoriesContainer(
                              context,
                              'Medical',
                              'assets/images/book.png',
                              mwidth * 0.4,
                              mwidth * 50 / mwidth)),
                      SizedBox(
                        // height: 20,
                        width: screenwidth(context) * .06,
                      ),
                      InkWell(
                          onTap: () {
                            if (loading) {
                              interstitialAd!.show();
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => HomeScreenPPT()));
                          },
                          child: CategoriesContainer(
                              context,
                              'PPT',
                              'assets/images/ppt.png',
                              mwidth * 0.4,
                              mwidth * 40 / mwidth)),
                      SizedBox(
                        // height: 20,
                        width: screenwidth(context) * .06,
                      ),
                      InkWell(
                          onTap: () {
                            if (loading) {
                              interstitialAd!.show();
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => AllBooksView(
                                          collectionName: 'Computer_science',
                                        )));
                          },
                          child: CategoriesContainer(
                              context,
                              'Computer Science',
                              'assets/images/computerbooks.png',
                              mwidth * 0.7,
                              mwidth * 55 / mwidth)),
                      SizedBox(
                        // height: 20,
                        width: screenwidth(context) * .06,
                      ),
                      InkWell(
                          onTap: () {
                            if (loading) {
                              interstitialAd!.show();
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => AllBooksView(
                                          collectionName: 'Books',
                                        )));
                          },
                          child: CategoriesContainer(
                              context,
                              'Islamic Books',
                              'assets/images/islamicbooks.png',
                              mwidth * 0.7,
                              mwidth * 55 / mwidth)),
                      SizedBox(
                        width: screenwidth(context) * .06,
                      ),
                      InkWell(
                          onTap: () {
                            if (loading) {
                              interstitialAd!.show();
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => AllBooksView(
                                          collectionName: 'Books',
                                        )));
                          },
                          child: Padding(
                              padding: EdgeInsets.only(),
                              child: CategoriesContainer(
                                  context,
                                  'General knowledge',
                                  'assets/images/generalknowledge.png',
                                  mwidth * 0.7,
                                  mwidth * 45 / mwidth))),
                      SizedBox(
                        width: screenwidth(context) * .02,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => AllProgrammesList()));
                        },
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: mheight * 30 / mheight,
                          color: Color(0xffE94560),
                        ),
                      ),
                      SizedBox(
                        width: mwidth * 10 / mwidth,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: mheight * 20 / mheight,
                ),
                CarouselSlider(
                  items: [
                    InkWell(
                      onTap: () {
                        if (loading) {
                          interstitialAd!.show();
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    AllBooksView(collectionName: 'Courses')));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.pinkAccent[200],
                            borderRadius: BorderRadius.circular(10)),
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
                  ],
                  options: CarouselOptions(
                    height: mheight * 100 / mheight,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    // aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    // viewportFraction: 0.8,
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
                                'You need something not here yet. click here',
                                style: GoogleFonts.kanit(
                                    color: Color(0xff0F3460),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
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
