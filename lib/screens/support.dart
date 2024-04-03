// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_hub/helper/Adids.dart';
import 'package:course_hub/model/course_model.dart';
import 'package:course_hub/widgets/support_ticket.dart';
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

class SupportTicket extends StatefulWidget {
  const SupportTicket({Key? key}) : super(key: key);

  @override
  State<SupportTicket> createState() => _SupportTicketState();
}

class _SupportTicketState extends State<SupportTicket> {
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  bool hasusersearched = false;
  bool loading = false;
  bool loadins = false;
  bool ticketstaus = false;

  String? title;
  String? author;
  String? dicription;
 
  String? name;
  String? email;
  FirebaseFirestore fstore = FirebaseFirestore.instance;
  TextEditingController titleedit = TextEditingController();
  TextEditingController discriptionedit = TextEditingController();
  BannerAd? bannerad;
  bool addloadd = false;
  bool bookloading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bannerad = BannerAd(
        size: AdSize.banner,
        adUnitId:BannerID8 ,
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
         
      });
     });}
  


  
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
                            'Request Page',
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
                      Text('Requested Resources', style: GoogleFonts.kanit(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700)),
                        SizedBox(height: 10,),
                         Text('Requested Resources', style: GoogleFonts.kanit(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700)),
                        SizedBox(height: 10,),
                        Expanded(
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('Ticket')
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snashot) {
                                  return loading
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: snashot.data !.docs.length,
                                          itemBuilder: (context, index) {
                                            DocumentSnapshot? data =
                                                snashot.data!.docs[index];
                                            return suppportTicket(
                                              ticketstaus,
                                              data['title'],
                                              data['dicription'],
                                              data['author'],
                                              data['doctitle'],
                                              context
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
                Row(
                  children: [
                    Center(
                      child: Text('No Internet Conection',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.kanit(
                              fontSize: 20, color: Colors.pink)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: 
        (){
            showDialog(
      context: context,
      builder: (ctx) => PlaceholderDialog(
      ),
    );
        }, child: Icon(Icons.add),backgroundColor: Colors.pink,),
      ),
    );
  }
}

