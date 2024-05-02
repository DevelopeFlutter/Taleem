// ignore_for_file: prefer_const_constructors, file_names, must_be_immutable, unnecessary_this

import 'package:course_hub/widgets/Books_description_widget.dart';
import 'package:course_hub/widgets/responsive_widgets.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helper/Adids.dart';
import '../helper/helper.dart';
import '../main.dart';

class Aboutscreen extends StatefulWidget {
  String coursename;
  String tutorname;
  String about;
  String imglink;
  String downloadlink;
  String demolink;
  String sendername;
  Aboutscreen(
      {Key? key,
      required this.about,
      required this.coursename,
      required this.imglink,
      required this.demolink,
      required this.downloadlink,
      required this.tutorname,
      required this.sendername})
      : super(key: key);

  @override
  State<Aboutscreen> createState() => _AboutscreenState();
}

class _AboutscreenState extends State<Aboutscreen> {
  InterstitialAd? interstitialAd;
  bool loading = false;
  BannerAd? bannerad;
  bool addloadd = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    InterstitialAd.load(
        adUnitId: InterstitialID1,
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
        adUnitId: BannerID2,
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
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                // channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
  }

  void showNotification() {
    setState(() {});
    flutterLocalNotificationsPlugin.show(
        0,
        widget.coursename,
        'Thanks For Using the App',
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0F3460),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: screenheight(context) / 7,
                  decoration: BoxDecoration(
                    color: Color(0xffE94560),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(30.0)),
                    // ignore: prefer_const_literals_to_create_immutables
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
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
                          'Taleem',
                          style: GoogleFonts.kanit(
                              fontSize: mheight * 25 / mheight,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                              color: Colors.white),
                        ),
                        Spacer(),
                       
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: screenheight(context) / 3,
                    width: screenwidth(context) / .9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                            bottom: Radius.circular(20.0)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.imglink))),
                  ),
                ),
                responsiveLeftRightPadding(
                  left: 25,
                  right: 10,
                  child: Row(
                    children: [
                      descriptionText(
                        widget.coursename,
                        mheight * 30 / mheight,
                        Colors.white,
                        FontWeight.w700,
                      )
                    ],
                  ),
                ),
                responsiveLeftRighBottomToptPadding(
                  left: 25,
                  right: 10,
                  top: 2,
                  bottom: 0,
                  child: Row(
                    children: [
                      Icon(
                        Icons.manage_accounts,
                        color: Color(0xffE94560),
                      ),
                      SizedBox(
                        width: mwidth * 10 / mwidth,
                      ),
                      descriptionText(
                        widget.tutorname,
                        mheight * 20 / mheight,
                        Color(0xffe94560),
                        FontWeight.w400,
                      )
                    ],
                  ),
                ),
                responsiveLeftRighBottomToptPadding(
                  left: 25.0,
                  right: 10,
                  top: 2,
                  bottom: 0,
                  child: Text(
                    'Provided By:  ${widget.sendername} ',
                    style: GoogleFonts.kanit(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffe94560)),
                  ),
                ),
                addloadd
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50,
                          child: AdWidget(ad: bannerad!),
                        ),
                      )
                    : SizedBox(
                        height: mheight * 50 / mheight,
                      ),
                responsiveLeftRighBottomToptPadding(
                  left: 25.0,
                  right: 10,
                  top: 2,
                  bottom: 0,
                  child: Row(
                    children: [
                      Expanded(
                          child: ReadMoreText(
                        widget.about,
                        style: GoogleFonts.kanit(
                            fontSize: mheight * 18 / mheight,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                        trimLines: 2,
                        colorClickableText: Colors.pink,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        moreStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.pink,
                            fontWeight: FontWeight.bold),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: screenheight(context) / 9,
        width: screenwidth(context),
        decoration: BoxDecoration(color: Color.fromARGB(255, 37, 53, 61)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Spacer(),
              TextButton.icon(
                  onPressed: () {
                    gotoouterapplicationfordemo();
                  },
                  icon: Icon(
                    Icons.launch,
                    size: 30,
                    color: Colors.pink,
                  ),
                  label: Text(
                    'Demo',
                    style: TextStyle(fontSize: 20, color: Colors.pink),
                  )),
              SizedBox(
                width: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffe94560),
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20), bottom: Radius.circular(20.0)),
                ),
                height: 60,
                width: 200,
                child: TextButton.icon(
                    onPressed: () {
                      showNotification();
                      gotoouterapplication();
                    },
                    icon: Icon(
                      Icons.download_rounded,
                      size: 30,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Download',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future gotoouterapplication() async {
    if (loading) {
      interstitialAd!.show();
    }
    Future.delayed(Duration(seconds: 3), () async {
      final url = Uri.parse(
        widget.downloadlink,
      );
      if (await canLaunchUrl(url)) {
        launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        // ignore: avoid_print
        print("Can't launch $url");
      }
    });
  }

  Future gotoouterapplicationfordemo() async {
    if (loading) {
      interstitialAd!.show().whenComplete(() async {
        Future.delayed(Duration(seconds: 3), () async {
          final url = Uri.parse(
            widget.demolink,
          );
          if (await canLaunchUrl(url)) {
            launchUrl(url, mode: LaunchMode.externalApplication);
          } else {
            // ignore: avoid_print
            print("Can't launch $url");
          }
        });
      });
    }
  }
}

class Aboutpptscreen extends StatefulWidget {
  String coursename;
  String tutorname;
  String imglink;
  String downloadlink;
  String demolink;
  String sendername;
  Aboutpptscreen({
    Key? key,
    required this.coursename,
    required this.imglink,
    required this.demolink,
    required this.downloadlink,
    required this.tutorname,
    required this.sendername,
  }) : super(key: key);

  @override
  State<Aboutpptscreen> createState() => _AboutpptscreenState();
}

class _AboutpptscreenState extends State<Aboutpptscreen> {
  InterstitialAd? interstitialAd;
  bool loading = false;
  BannerAd? bannerad;
  bool addloadd = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    InterstitialAd.load(
        adUnitId: InterstitialID2,
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
        adUnitId: BannerID1,
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
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                // channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
  }

  void showNotification() {
    setState(() {});
    flutterLocalNotificationsPlugin.show(
        0,
        widget.coursename,
        'Thanks For Using the App',
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0F3460),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: screenheight(context) / 7,
                  decoration: BoxDecoration(
                    color: Color(0xffE94560),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(30.0)),
                    // ignore: prefer_const_literals_to_create_immutables
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
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
                          'COURSE HUB',
                          style: GoogleFonts.kanit(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                              color: Colors.white),
                        ),
                        Spacer(),
                        // CircleAvatar(
                        //   backgroundColor: Color(0xffF8F8F8),
                        // )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: screenheight(context) / 3,
                    width: screenwidth(context) / .9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                            bottom: Radius.circular(20.0)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.imglink))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.coursename,
                          textAlign: TextAlign.left,
                          softWrap: true,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.kanit(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 25.0,
                    right: 10,
                    top: 2,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.manage_accounts,
                        color: Color(0xffE94560),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.tutorname,
                        style: GoogleFonts.kanit(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffe94560)),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 25.0,
                    right: 10,
                    top: 2,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.manage_accounts,
                        color: Color(0xffE94560),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.sendername,
                        style: GoogleFonts.kanit(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffe94560)),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                addloadd
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50,
                          child: AdWidget(ad: bannerad!),
                        ),
                      )
                    : SizedBox(
                        height: 50,
                        child: Center(
                          child: Text(
                            '.',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                // Padding(
                //   padding: const EdgeInsets.only(
                //     left: 25.0,
                //     right: 10,
                //     top: 2,
                //   ),
                //   child: Row(
                //     children: [
                //       Expanded(
                //           child: ReadMoreText(
                //         widget.about,
                //         style: GoogleFonts.kanit(
                //             fontSize: 18,
                //             color: Colors.white,
                //             fontWeight: FontWeight.w400),
                //         trimLines: 2,
                //         colorClickableText: Colors.pink,
                //         trimMode: TrimMode.Line,
                //         trimCollapsedText: 'Show more',
                //         trimExpandedText: 'Show less',
                //         moreStyle: TextStyle(
                //             fontSize: 16,``````````````````````````
                //             color: Colors.pink,
                //             fontWeight: FontWeight.bold),
                //       )),
                //     ],
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: screenheight(context) / 9,
        width: screenwidth(context),
        decoration: BoxDecoration(color: Color.fromARGB(255, 37, 53, 61)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Spacer(),
              TextButton.icon(
                  onPressed: () {
                    gotoouterapplicationfordemo();
                  },
                  icon: Icon(
                    Icons.launch,
                    size: 30,
                    color: Colors.pink,
                  ),
                  label: Text(
                    'Demo',
                    style: TextStyle(fontSize: 20, color: Colors.pink),
                  )),
              SizedBox(
                width: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffe94560),
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20), bottom: Radius.circular(20.0)),
                ),
                height: 60,
                width: 200,
                child: TextButton.icon(
                    onPressed: () {
                      showNotification();
                      gotoouterapplication();
                    },
                    icon: Icon(
                      Icons.download_rounded,
                      size: 30,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Download',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future gotoouterapplication() async {
    if (loading) {
      interstitialAd!.show();
    }
    Future.delayed(Duration(seconds: 3), () async {
      final url = Uri.parse(
        widget.downloadlink,
      );
      if (await canLaunchUrl(url)) {
        launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        // ignore: avoid_print
        print("Can't launch $url");
      }
    });
  }

  Future gotoouterapplicationfordemo() async {
    if (loading) {
      interstitialAd!.show().whenComplete(() async {
        Future.delayed(Duration(seconds: 3), () async {
          final url = Uri.parse(
            widget.demolink,
          );
          if (await canLaunchUrl(url)) {
            launchUrl(url, mode: LaunchMode.externalApplication);
          } else {
            // ignore: avoid_print
            print("Can't launch $url");
          }
        });
      });
    }
  }
}
