import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_hub/helper/Adids.dart';
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
import 'drawer.dart';

class Ticketdetail extends StatefulWidget {
  const Ticketdetail({
   required this.title,
   required this.authorname,
   required this.discription,
   required this.link,
    Key? key,}) : super(key: key);
    final String? title;
    final String? authorname;
    final String? discription;
    final String? link;


  @override
  State<Ticketdetail> createState() => _TicketdetailState();
}

class _TicketdetailState extends State<Ticketdetail> {
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  bool hasusersearched = false;
  bool loading = false;
  bool loadins = false;
  bool ticketstaus = false;

  String? title;
  String? author;
  String? dicription;
  String? doctitle;
 
  String? name;
  String? email;
  FirebaseFirestore fstore = FirebaseFirestore.instance;
  TextEditingController titleedit = TextEditingController();
  TextEditingController discriptionedit = TextEditingController();
  BannerAd? bannerad;
  bool addloadd = false;
  bool bookloading = false;
  InterstitialAd? interstitialAd;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
     InterstitialAd.load(
        adUnitId:InterstitialID4 ,
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
        adUnitId:BannerID9 ,
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
  getticketdata()async{
     await fstore.collection('Ticket').get().then((value) {
      final ticketmodel = Ticketmodel.fromMap(value.docs);
      setState(() {
        title  = ticketmodel.title;
        author = ticketmodel.author;
        dicription= ticketmodel.dicription;
        doctitle = ticketmodel.doctitle;

         
      });
     });}
  


  
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
                              'Ticket Detail',
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
                       Material(
                        elevation: 2,
                      borderRadius: BorderRadius.circular(10),
                         child: Container(
                         
                          child: Column(
                            children: [
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Material(
                                    color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(10),
                                     child: Padding(
                                       padding: const EdgeInsets.only(top: 10.0, left: 20, bottom: 10, right: 20),
                                       child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.book_rounded ,color: Colors.pink,),
                                          SizedBox(width: 10,),
                                          Text('${widget.title}', style: GoogleFonts.kanit(fontSize: 22, color: Colors.pink),)
                                        ],
                                       ),
                                     ),
                                   ),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Material(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                     child: Padding(
                                       padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 10),
                                       child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.manage_accounts ,color: Colors.pink,),
                                          SizedBox(width: 10,),
                                          Text('${widget.discription}', style: GoogleFonts.kanit(fontSize: 20),)
                                        ],
                                       ),
                                     ),
                                   ),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Material(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                     child: Padding(
                                       padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 10),
                                       child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.details ,color: Colors.pink,),
                                          SizedBox(width: 10,),
                                         Expanded(
                                           child: Row(
                                                             children: [
                                                               Expanded(
                                                                   child: ReadMoreText(
                                                                 '${widget.authorname}',
                                                                 style: GoogleFonts.kanit(
                                                                     fontSize: 18,
                                                                     color: Color(0xff0F3460),
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
                                     ),
                                   ),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Material(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                     child: Padding(
                                       padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 10),
                                       child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.link ,color: Colors.pink,),
                                          SizedBox(width: 10,),
                                         Expanded(
                                           child: Row(
                                                             children: [
                                                               Expanded(
                                                                   child: ReadMoreText(
                                                                 '${widget.link}',
                                                                 style: GoogleFonts.kanit(
                                                                     fontSize: 18,
                                                                     color: Color(0xff0F3460),
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
                                     ),
                                   ),
                                 ),
                            ],
                            ),
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.all(2.0),
                         
                         child: Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 400,
                            child: Column(
                              children: [
                                 Text(
                              'You Want to Help Community',
                              style: GoogleFonts.kanit(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1,
                                  color: Colors.pink),
                            ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('If You have this Book please click button "Donate this Resource" and Send it to admin to make it available for other peple '),
                                ),
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Text('This  book will be upload with your reference',style: GoogleFonts.kanit(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1,
                                    color: Colors.pink), ),
                                 ),
                                  Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Row(
                                     children: [
                                       Text('Method',style: GoogleFonts.kanit(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1,
                                        color: Colors.pink), ),
                                     ],
                                   ),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Row(
                                     children: [
                                       Text('1. Just Upload the book to Google Drive, \n 2. Get and accessable link of that book. \n (Make shure to give set permsiion \n "anyone with link"). \n 3. Provide remaining information correctly.',
                                  style: GoogleFonts.kanit(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1,
                                        color: Color(0xff0F3460)), ),
                                     ],
                                   ),
                                 ),
                                 TextButton(onPressed: (){
                                   if (loading) {
                      interstitialAd!.show();
                    }
                                  Navigator.push(context, MaterialPageRoute(builder: (Context)=> Donateresourse() ));
                                 }, child: Material(
                                  color: Color(0xff0F3460),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Donate this Resource', style: TextStyle(color: Colors.white),),
                                  )))
                       
                              ],
                            ),
                          ),
                         ),
                       )
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
