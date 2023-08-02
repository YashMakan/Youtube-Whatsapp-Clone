//import 'dart:math';
//import 'package:camera_camera/camera_camera.dart';
//import 'package:flutter/material.dart';
//import 'package:whatsapp_redesign/views/status_page/status_views/camera_view.dart';
//import 'package:whatsapp_redesign/views/status_page/status_views/video_view.dart';
//
//import '../../main.dart';
//
//class NewStatusPage extends StatefulWidget {
//  const NewStatusPage({Key? key}) : super(key: key);
//
//  @override
//  _NewStatusPageState createState() => _NewStatusPageState();
//}
//
//class _NewStatusPageState extends State<NewStatusPage> {
//  late CameraController _cameraController;
//  late Future<void> cameraValue;
//  bool isRecording = false;
//  bool flash = false;
//  bool isCameraFront = true;
//  double transform = 0;
//
//  @override
//  void initState() {
//    super.initState();
//    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
//    cameraValue = _cameraController.initialize();
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//    _cameraController.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Stack(
//        children: [
//          FutureBuilder(
//              future: cameraValue,
//              builder: (context, snapshot) {
//                if (snapshot.connectionState == ConnectionState.done) {
//                  return SizedBox(
//                      width: MediaQuery.of(context).size.width,
//                      height: MediaQuery.of(context).size.height,
//                      child: CameraPreview(_cameraController));
//                } else {
//                  return const Center(
//                    child: CircularProgressIndicator(),
//                  );
//                }
//              }),
//          Positioned(
//            bottom: 0.0,
//            child: Container(
//              color: Colors.black,
//              padding: const EdgeInsets.only(top: 5, bottom: 5),
//              width: MediaQuery.of(context).size.width,
//              child: Column(
//                children: [
//                  Row(
//                    mainAxisSize: MainAxisSize.max,
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: [
//                      IconButton(
//                          icon: Icon(
//                            flash ? Icons.flash_on : Icons.flash_off,
//                            color: Colors.white,
//                            size: 28,
//                          ),
//                          onPressed: () {
//                            setState(() {
//                              flash = !flash;
//                            });
//                            flash
//                                ? _cameraController
//                                .setFlashMode(FlashMode.torch)
//                                : _cameraController.setFlashMode(FlashMode.off);
//                          }),
//                      GestureDetector(
//                        onLongPress: () async {
//                          await _cameraController.startVideoRecording();
//                          setState(() {
//                            isRecording = true;
//                          });
//                        },
//                        onLongPressUp: () async {
//                          XFile videopath =
//                          await _cameraController.stopVideoRecording();
//                          setState(() {
//                            isRecording = false;
//                          });
//                          Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (builder) => VideoView(
//                                    path: videopath.path,
//                                  )));
//                        },
//                        onTap: () {
//                          if (!isRecording) takePhoto(context);
//                        },
//                        child: isRecording
//                            ? const Icon(
//                          Icons.radio_button_on,
//                          color: Colors.red,
//                          size: 80,
//                        )
//                            : const Icon(
//                          Icons.panorama_fish_eye,
//                          color: Colors.white,
//                          size: 70,
//                        ),
//                      ),
//                      IconButton(
//                          icon: Transform.rotate(
//                            angle: transform,
//                            child: const Icon(
//                              Icons.flip_camera_ios,
//                              color: Colors.white,
//                              size: 28,
//                            ),
//                          ),
//                          onPressed: () async {
//                            setState(() {
//                              isCameraFront = !isCameraFront;
//                              transform = transform + pi;
//                            });
//                            int cameraPos = isCameraFront ? 0 : 1;
//                            _cameraController = CameraController(
//                                cameras[cameraPos], ResolutionPreset.high);
//                            cameraValue = _cameraController.initialize();
//                          }),
//                    ],
//                  ),
//                  const SizedBox(
//                    height: 4,
//                  ),
//                  const Text(
//                    "Hold for Video, tap for photo",
//                    style: TextStyle(
//                      color: Colors.white,
//                    ),
//                    textAlign: TextAlign.center,
//                  )
//                ],
//              ),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//
//  void takePhoto(BuildContext context) async {
//    XFile file = await _cameraController.takePicture();
//    Navigator.push(
//        context,
//        MaterialPageRoute(
//            builder: (builder) => CameraView(
//              path: file.path,
//            )));
//  }
//}
