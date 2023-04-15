import 'package:booksapp/screen/consted/newpage.dart';
import 'package:booksapp/screen/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      body:SingleChildScrollView(
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

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 80,),
              Lottie.asset(
                'assets/manandbook.json',
                height: 200,
                animate: true,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(color: Colors.white70,wordSpacing: 0.6,fontSize: 14),
                  ),
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Write Your Email',
                    filled: true,
                    hintStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(color: Colors.white70,wordSpacing: 0.6,fontSize: 14),
                ),
                    fillColor: Colors.grey.withOpacity(0.2),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:BorderSide(color:Colors.grey)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:BorderSide(
                            color: Colors.grey,
                            width: 1
                        )
                    ),

                  ),

                ),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  keyboardType: TextInputType.text,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(color: Colors.white70,wordSpacing: 0.6,fontSize: 14),
                  ),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: 'Write Your Password',
                    filled: true,
                    hintStyle:GoogleFonts.poppins(
                  textStyle: TextStyle(color: Colors.white70,wordSpacing: 0.6,fontSize: 14),
                ),
                    fillColor: Colors.grey.withOpacity(0.2),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:BorderSide(color:Colors.grey)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:BorderSide(
                            color: Colors.grey,
                            width: 1
                        )
                    ),

                  ),

                ),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20,),
                child: InkWell(
                  onTap: (){
                    newPage(context, HomePage());
                  },
                  child: Container(
                    height: 50,
                    width: size.width,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.withOpacity(0.2)
                    ),
                    child: Center(
                      child: Text("Login",style: GoogleFonts.poppins(
                        textStyle: TextStyle(color: Colors.white70,wordSpacing: 0.6,fontWeight: FontWeight.bold,fontSize: 14),
                      ),)
                    ),
                  ),
                ),
              )
            ],
          )
          // Container(
          //   height: size.height,
          //   width: size.width,
          //   color: Colors.black.withOpacity(0.5)
          //     )
            
          ],
        ),
      )

    );
  }
}
