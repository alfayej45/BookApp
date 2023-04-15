import 'package:booksapp/screen/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  State<SplashPage> createState() => _SplashPageState();
}
class _SplashPageState extends State<SplashPage> {
 @override
  void initState() {
    Future.delayed(const Duration(seconds:6),
        (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginPage()));
        }
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
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
          Container(
            height: size.height,
            width: size.width,
            child:Lottie.asset(
              'assets/splash-books.json',
              height: 200,
              animate: true,
              // fit: BoxFit.fill,
            ) ,
          ),
        ],
      ),);
  }
}
