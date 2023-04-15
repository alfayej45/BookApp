
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'arcamera.dart';
// dart pub publish // to publish package
class AugmentedRealityPlugin extends StatefulWidget
{
  final String imageLink;

  AugmentedRealityPlugin(this.imageLink);

  @override
  _AugmentedRealityPluginState createState() => _AugmentedRealityPluginState();
}

class _AugmentedRealityPluginState extends State<AugmentedRealityPlugin>
{
  var _cameraController;
  List<CameraDescription> cameraMovements = [];
  bool isCameraLoading = false;


  void initCameraStreaming() async
  {
    setState(() {
      isCameraLoading = true;
    });

    try
    {
      cameraMovements = await availableCameras();
      _cameraController = CameraController(cameraMovements[0], ResolutionPreset.ultraHigh);
      await _cameraController.initialize();
      setState(() {
        isCameraLoading = false;
      });

      print('Camera Controller:\n');
      print(_cameraController.toString());
    }
    catch (errorMessage)
    {
      setState(() {
        isCameraLoading = false;
      });

      print(errorMessage.toString());
    }
  }


  @override
  void initState()
  {
    super.initState();

    initCameraStreaming();
  }


  double xAxisPosition = 130;
  double yAxisPosition = 150;
  double height = 150;
  double onchange = 150;


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body:
      isCameraLoading?
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ):

      Stack(
        children: [
          Container(
              height: 1000,
              width: MediaQuery.of(context).size.width,
              child: AugmentedRealityWidget(_cameraController)),
          Positioned(
            top: yAxisPosition,
            left: xAxisPosition,
            child: GestureDetector(
              onPanUpdate: (tapInfo)
              {
                setState(() {
                  xAxisPosition += tapInfo.delta.dx;
                  yAxisPosition += tapInfo.delta.dy;
                });
              },
              child:
              Container(
                height: onchange,
                color: Colors.transparent,
                child: Image.network(
                  widget.imageLink == null
                      ?'https://www.freepnglogos.com/uploads/furniture-png/furniture-png-transparent-furniture-images-pluspng-15.png'
                      : widget.imageLink, height: onchange,width: onchange,
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 10,
              child: Slider(
                value: onchange,
                min: 10,
                max: 300,
                onChanged: (value){
                  setState(() {
                    onchange = value;
                  });
                },
              )
          )
        ],
      ),
    );
  }
}



