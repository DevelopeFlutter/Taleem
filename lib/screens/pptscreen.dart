// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_hub/helper/Adids.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../Network checker/network_aware.dart';
import '../Network checker/network_service.dart';
import '../helper/helper.dart';
import '../model/usermodel.dart';
import '../widgets/course_card.dart';
import 'drawer.dart';

class HomeScreenPPT extends StatefulWidget {
  const HomeScreenPPT({Key? key}) : super(key: key);

  @override
  State<HomeScreenPPT> createState() => _HomeScreenPPTState();
}

class _HomeScreenPPTState extends State<HomeScreenPPT> {
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  bool hasusersearched = false;
  bool loading = false;
  bool loadins = false;

  String? coursenames;
  String? tutorname;
  String? category;
  String? about;
  String? demolink;
  String? downloadlink;
  String? name;
  String? email;
  FirebaseFirestore fstore = FirebaseFirestore.instance;
  TextEditingController sraechctr = TextEditingController();
  BannerAd? bannerad;
  bool addloadd = false;
  bool bookloading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bannerad = BannerAd(
        size: AdSize.banner,
        adUnitId:BannerID7,
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
    getuserdata();
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

  List searchresult = [];
  seach(String query) async {
    if (sraechctr.text.isNotEmpty) {
      setState(() {
        hasusersearched = true;
        loadins = true;
      });
      final result = await FirebaseFirestore.instance
          .collection('PPT')
          .where('searchkeyword', arrayContains: query.toUpperCase())
          .get();
      setState(() {
        loadins = false;
        searchresult = result.docs.map((e) => e.data()).toList();
      });
    }
  }

  final refcolec = FirebaseFirestore.instance.collection('PPT');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff0F3460),
        key: _scaffoldkey,
        drawer: drawer(context),
        body: StreamProvider<NetworkStatus>(
          initialData: NetworkStatus.Online,
          create: (context) =>
              NetworkStatusService().networkStatusController.stream,
          child: NetworkAwareWidget(
            onlineChild: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: screenheight(context) / 6,
                      decoration: BoxDecoration(
                        color: Color(0xffE94560),
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(30.0)),
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
                  child: Column(
                    children: [
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
                            'PPT HUB',
                            style: GoogleFonts.kanit(
                                fontSize: 25,
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
                        'Hi! $name',
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
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Expanded(
                                  child: TextField(
                                controller: sraechctr,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                                mouseCursor: MouseCursor.uncontrolled,
                                onChanged: (val) {
                                  seach(val);
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
                                          sraechctr.clear();
                                          FocusScope.of(context).unfocus();
                                        });
                                      },
                                    ),
                                    hintText: 'Search PPT',
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
                      SizedBox(
                        height: 80,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AdWidget(ad: bannerad!),
                        ),
                      ),
                      hasusersearched
                          ? Expanded(
                              child: loadins
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.pink,
                                      ),
                                    )
                                  : ListView.separated(
                                      itemCount: searchresult.length,
                                      itemBuilder: (context, index) {
                                        return pptcard(
                                            context,
                                            searchresult[index]['imagelink'],
                                            searchresult[index]['pptname'],
                                            searchresult[index]['tutorname'],
                                            searchresult[index]['category'],
                                            searchresult[index]['demolink'],
                                            searchresult[index]
                                                ['downloadlink'],
                                                searchresult[index]['sendername']);
                                      },
                                      separatorBuilder: (context, index) {
                                        return index % 6 == 0
                                            ? SizedBox(
                                                height: 50,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child:
                                                      AdWidget(ad: bannerad!),
                                                ),
                                              )
                                            : SizedBox(
                                                height: 50,
                                                child: Center(child: Text('.')),
                                              );
                                      }),
                            )
                          : Expanded(
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('PPT')
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                 
                                  if (snapshot.data == null) {
                                    return CircularProgressIndicator();
                                  }
                                    return    ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (context, index) {
                                            DocumentSnapshot? data =
                                                snapshot.data!.docs[index];
                                            return pptcard(
                                              context,
                                              data['imagelink'],
                                              data['pptname'],
                                              data['tutorname'],
                                              data['category'],
                                              data['demolink'],
                                              data['downloadlink'],
                                              data['sendername'],
                                            );
                                          },
                                        );
                                },
                              ),
                            ),
                    ],
                  ),
                )
              ],
            ),
            offlineChild: Column(
              children: [
                Container(
                  height: screenheight(context) / 6,
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
                ),
                Center(
                  child: Text('Please Check  Your Internet Conection',
                      textAlign: TextAlign.center,
                      style:
                          GoogleFonts.kanit(fontSize: 20, color: Colors.pink)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
