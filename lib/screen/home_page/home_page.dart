import 'package:booksapp/screen/consted/newpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../categoricPage/categoricPage..dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final Stream<QuerySnapshot> booksStream =
      FirebaseFirestore.instance.collection('books').snapshots();
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: size.height,
              width: size.width,
              child: SvgPicture.asset("assets/backgroundsvg.svg",fit: BoxFit.fill,),
            ),
            Container(
              height: size.height,
              width: size.width,
              color:Colors.black.withOpacity(0.8),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15,top: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("MD AL-FAYEJ ALOM",style: GoogleFonts.poppins(
                            textStyle: TextStyle(color: Colors.white70,wordSpacing: 0.6,fontWeight: FontWeight.bold,fontSize: 14),
                          ),),
                          Text("What are you reding today?",style: GoogleFonts.poppins(
                            textStyle: TextStyle(color: Colors.white70,wordSpacing: 0.6,fontWeight: FontWeight.normal,fontSize: 12),
                          ),)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 18),
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.cyanAccent,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15,),
                  Text("Programming",style: GoogleFonts.poppins(
                    textStyle: TextStyle(color: Colors.white70,wordSpacing: 0.6,fontWeight: FontWeight.bold,fontSize: 18),
                  ),),
                  SizedBox(height: 10,),
              StreamBuilder<QuerySnapshot>(
                stream: booksStream,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LinearProgressIndicator();
                  }
                  return SizedBox(
                    height: 130,
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      primary: false,
                      itemBuilder: (context, index){
                        DocumentSnapshot data = snapshot.data!.docs[index];
                        return  InkWell(
                          onTap: (){
                            newPage(context, CategoricPage(id:data["id"], bookName: data['book_cat'],));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 130,
                                    width: 130,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(image: NetworkImage(data["image"]),fit: BoxFit.fill)
                                    ),
                                  ),
                                  // SizedBox(height: 10,),
                                  // Text("Best Books",style: GoogleFonts.poppins(
                                  //   textStyle: TextStyle(color: Colors.black,wordSpacing: 0.6,fontWeight: FontWeight.bold,fontSize: 14),
                                  // ),),

                                ],
                              ),
                            ),
                          ),
                        );

                      },

                    ),
                  );
                },
              )],

              ),
            ),
          ],
        ),
      ),
    );
  }
}



