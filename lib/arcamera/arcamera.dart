import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


/// A widget showing a live camera preview.
class InitAugmentedRealityPlugin extends StatelessWidget
{
  /// Creates a preview widget for the given camera controller.
  const InitAugmentedRealityPlugin(this._cameraController, {this.childWidget});

  /// The controller for the camera that the preview is shown for.
  final CameraController _cameraController;

  /// A widget to overlay on top of the camera preview
  final Widget? childWidget;

  @override
  Widget build(BuildContext context)
  {
    return _cameraController.value.isInitialized
        ? AspectRatio(
      aspectRatio: _isOrientationLandscape()
          ? _cameraController.value.aspectRatio
          : (1 / _cameraController.value.aspectRatio),
      child: Stack(
        fit: StackFit.expand,
        children: [
          _nowWrapInRotatedBox(child: _cameraController.buildPreview()),
          childWidget ?? Container(),
        ],
      ),
    )
        : Container();
  }

  Widget _nowWrapInRotatedBox({required Widget child})
  {
    if (defaultTargetPlatform != TargetPlatform.android)
    {
      return child;
    }

    return RotatedBox(
      quarterTurns: _nowGetQuarterTurns(),
      child: child,
    );
  }

  bool _isOrientationLandscape()
  {
    return [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]
        .contains(_nowGetPhoneApplicableOrientation());
  }

  int _nowGetQuarterTurns()
  {
    Map<DeviceOrientation, int> turns = {
      DeviceOrientation.portraitUp: 0,
      DeviceOrientation.landscapeLeft: 1,
      DeviceOrientation.portraitDown: 2,
      DeviceOrientation.landscapeRight: 3,
    };
    return turns[_nowGetPhoneApplicableOrientation()]!;
  }

  DeviceOrientation _nowGetPhoneApplicableOrientation()
  {
    return _cameraController.value.isRecordingVideo
        ? _cameraController.value.recordingOrientation!
        : (_cameraController.value.lockedCaptureOrientation ??
        _cameraController.value.deviceOrientation);
  }
}


class AugmentedRealityWidget extends StatelessWidget
{
  AugmentedRealityWidget(this.cameraController);
  final cameraController;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: 1000,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)
        ),
        child:
        InitAugmentedRealityPlugin(cameraController),
      ),
    ]);
  }
}