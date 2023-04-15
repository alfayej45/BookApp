import 'package:booksapp/screen/consted/newpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../pdf_view_page/pdf_viewpage.dart';
class CategoricPage extends StatefulWidget {
  final String id;
  final String bookName;
  const CategoricPage({Key? key, required this.id, required this.bookName}) : super(key: key);

  @override
  State<CategoricPage> createState() => _CategoricPageState();
}

class _CategoricPageState extends State<CategoricPage> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
         centerTitle: true,
        backgroundColor: Colors.black,
        bottomOpacity: 0.0,
        elevation: 0.0,
        title: Text("${widget.bookName}",style: TextStyle(fontSize: 18 ,color: Colors.white),),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: size.height,
              width: size.width,
              child: SvgPicture.asset("assets/backgroundsvg.svg",fit: BoxFit.cover,),
            ),
            Container(
              height: size.height,
              width: size.width,
              color:Colors.black.withOpacity(0.8),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("books").doc("${widget.id}").collection("bookList").snapshots(),
                builder: (context,snapshot){
                print("${widget.id}");
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LinearProgressIndicator();
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      primary: false,
                      itemBuilder: (context,index){
                        DocumentSnapshot data = snapshot.data!.docs[index];
                        return  Padding(
                          padding: const EdgeInsets.only(top: 50,left: 10,right: 10),
                          child: InkWell(
                            onTap: (){

                              newPage(context, PdfViewPage(name: data["authorName"], pdf: data["pdf"],));

                            },
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  height: size.height*0.15,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.transparent,
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Colors.grey.withOpacity(0.5),
                                    //     spreadRadius: 3,
                                    //     blurRadius: 5,
                                    //     offset: Offset(0, 3), // changes position of shadow
                                    //   ),
                                    //],
                                  ),
                                  child:Padding(
                                    padding: const EdgeInsets.only(left: 105),
                                    child: Text("${data["authorName"]}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),),
                                  ) ,
                                ),
                                Positioned(
                                bottom: 0,
                                    child: ClipRRect(
                                          borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),
                                        child: Image(image:NetworkImage("${data["image"]}"),fit: BoxFit.cover,height:size.height*0.180 ,width: 100,))

                                    // Container(
                                    //   height: size.height*0.195,
                                    //   width: 120,
                                    //   decoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.circular(15),
                                    //       color: Colors.white,
                                    //       image: DecorationImage(image:NetworkImage("${data["image"]}"),fit: BoxFit.cover)
                                    //
                                    //   ),
                                    //
                                    // )
                                )

                              ],
                            ),
                          ),
                        );
                      });
                }
            )],
        ),
      ),

    );
  }
}
