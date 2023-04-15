
import 'package:booksapp/screen/splash_screen/splash_page.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'arcamera/document-reality_plugin.dart';


List<CameraDescription>? cameras;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (errorMessage) {
    print(errorMessage.description);
  }
  runApp(const MyApp());


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }

}
class AugmentedRealityView extends StatefulWidget {
  const AugmentedRealityView({Key? key}) : super(key: key);

  @override
  _AugmentedRealityViewState createState() => _AugmentedRealityViewState();
}

class _AugmentedRealityViewState extends State<AugmentedRealityView> {
  @override
  Widget build(BuildContext context) {
    return AugmentedRealityPlugin(
        'https://www.freepnglogos.com/uploads/furniture-png/furniture-png-transparent-furniture-images-pluspng-15.png'
    );
  }
}

