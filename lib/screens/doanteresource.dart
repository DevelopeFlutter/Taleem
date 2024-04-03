import 'package:course_hub/helper/Adids.dart';
import 'package:course_hub/services/Authservices.dart';
import 'package:flutter/material.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_hub/screens/doanteresource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../Network checker/network_aware.dart';
import '../Network checker/network_service.dart';
import '../helper/helper.dart';
import '../model/course_model.dart';
import '../model/usermodel.dart';
import '../widgets/custom_textfield.dart';
import 'drawer.dart';

class Donateresourse extends StatefulWidget {
  const Donateresourse({
   
    Key? key,}) : super(key: key);


  @override
  State<Donateresourse> createState() => _DonateresourseState();
}

class _DonateresourseState extends State<Donateresourse> {
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  bool hasusersearched = false;
  bool loading = false;
  bool loadins = false;
  bool ticketstaus = false;
  

 
  String? name;
  String? email;
  FirebaseFirestore fstore = FirebaseFirestore.instance;
  TextEditingController booktitle = TextEditingController();
  TextEditingController coverlink = TextEditingController();
  TextEditingController gdrivelink = TextEditingController();
  TextEditingController detail = TextEditingController();
    TextEditingController authordetail = TextEditingController();
    TextEditingController yournmae = TextEditingController();
     final _formkey = GlobalKey<FormState>();
     Authservices  authservice = Authservices();
  BannerAd? bannerad;
  bool addloadd = false;
  bool bookloading = false;

  @override
  void dispose() {
    yournmae.dispose();
    booktitle.dispose();
    coverlink.dispose();
    gdrivelink.dispose();
    detail.dispose();
    authordetail.dispose();
    
    
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bannerad = BannerAd(
        size: AdSize.banner,
        adUnitId:BannerID5 ,
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

  sendtoadmin()async{
    await  authservice.donationdetail(
      context,
      booktitle.text,
      authordetail.text,
      coverlink.text,
      gdrivelink.text,
      yournmae.text
      
    );
  }
  


  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff0F3460),
        key: _scaffoldkey,
        drawer: drawer(context),
        body: SingleChildScrollView(
          child: StreamProvider<NetworkStatus>(
            initialData: NetworkStatus.Online,
            create: (context) =>
                NetworkStatusService().networkStatusController.stream,
            child: NetworkAwareWidget(
              onlineChild: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: screenheight(context) / 7,
                        decoration: BoxDecoration(
                          color: Color(0xffE94560),
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(30.0)),
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
                              'Donation Form',
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
                          'Hi! ${name}',
                          style: TextStyle(
                              color: Color(0xffF8F8F8),
                              fontSize: 25,
                              fontWeight: FontWeight.w400),
                        ),
                       
                         SizedBox(height: 40,),
                        SizedBox(
                          height: 80,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AdWidget(ad: bannerad!),
                          ),
                        ),
                       
                       Form(
                        key: _formkey,
                        child: Container(
                          decoration: BoxDecoration(

                          ),
                          child: Column(
                            children: [
                            customtextfeild(
                              Icon(Icons.book_outlined, color: Colors.pink,),
                              'Enter Book Name',
                             (value) {
                            if (value.isEmpty) {
                      Text('Please Enter Book name');
                    }
                  },
                  booktitle
                            ),
                             SizedBox(height: 10,),
                             customtextfeild(
                              Icon(Icons.manage_accounts, color: Colors.pink,),
                              'Enter Author Names',
                             (value) {
                            if (value.isEmpty) {
                      Text('Please Enter Book Author name');
                    }
                  },
                  authordetail
                            ),
                             SizedBox(height: 10,),
                             customtextfeild(
                              Icon(Icons.image, color: Colors.pink,),
                              'Enter Cover Page Link here',
                             (value) {
                            if (value.isEmpty) {
                      Text('Please Enter a link from internet For cover page of Book');
                    }
                  },
                  coverlink
                            ),
                             SizedBox(height: 10,),
                             customtextfeild(
                              Icon(Icons.g_mobiledata_outlined, color: Colors.pink,),
                              'Enter Google drive Link',
                             (value) {
                            if (value.isEmpty) {
                      Text('Please Enter Download link with permission with link');
                    }
                  },
              
                  gdrivelink
                            ),
                            SizedBox(height: 10,),
                             customtextfeild(
                              Icon(Icons.account_box, color: Colors.pink,),
                              'Enter Your Name',
                             (value) {
                            if (value.isEmpty) {
                      Text('Please Enter Your Full name');
                    }
                  },
                  yournmae
                            ),
                            TextButton(onPressed: ()async{
                             if(_formkey.currentState!.validate()){
                              setState(() {
                               loading = true;
                              });
                               await sendtoadmin();
                               yournmae.clear();
                               authordetail.clear();
                               booktitle.clear();
                               gdrivelink.clear();
                               coverlink.clear();
                               detail.clear();
                               setState(() {
                                 loading = false;
                               });
                             }
                            }, child: Material(color: Colors.pink[300],
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: loading ? CircularProgressIndicator(value: 20,) :Text('Submit To Admin', style: TextStyle(color:  Colors.white)),
                              )))
                            ],
                          ),
                        )),
                        //  Text('${widget.title}',)
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
                    child: Row(
                      children: [
                        Text('No Internet Conection',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.kanit(
                                fontSize: 20, color: Colors.pink)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
