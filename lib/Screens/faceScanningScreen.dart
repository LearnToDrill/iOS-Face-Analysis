import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:face_analysis/Resources/commonClass.dart';
import 'package:face_analysis/Resources/constants.dart';
import 'package:face_analysis/Screens/ScanResults/scanResultsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:permission_handler/permission_handler.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

///MARK:- Face scanning screen
class FaceScanningScreen extends StatefulWidget {
  const FaceScanningScreen({Key? key, required this.camera}) : super(key: key);
  final CameraDescription camera;

  @override
  State<FaceScanningScreen> createState() => _FaceScanningScreenState();
}

class _FaceScanningScreenState extends State<FaceScanningScreen>
    with WidgetsBindingObserver {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  PermissionStatus? _permissionStatus;

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    WidgetsBinding.instance?.addPostFrameCallback(onLayoutDone);
    super.initState();
    initCamera();
  }

  void onLayoutDone(Duration timeStamp) async {
    _permissionStatus = await Permission.camera.status;
    setState(() {});
  }

  void initCamera() async {
    if (Platform.isIOS) {
      if (await Permission.camera.request().isPermanentlyDenied) {
        if (_permissionStatus != PermissionStatus.granted) {
          // askCameraPermission(context);
        }
        setState(() {});
      }
      _controller = CameraController(widget.camera, ResolutionPreset.max,
          enableAudio: false);
      _initializeControllerFuture = _controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    } else {
      if (await Permission.camera.request().isGranted) {
        _permissionStatus = await Permission.camera.status;
        setState(() {});
      }
      if (_permissionStatus != null) {
        if (_permissionStatus!.isGranted) {
          _controller = CameraController(widget.camera, ResolutionPreset.max,
              enableAudio: false);
          _initializeControllerFuture = _controller.initialize().then((_) {
            if (!mounted) {
              return;
            }
            setState(() {});
          });
        } else {
          askCameraPermission(context);
        }
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_controller == null || _controller.value.isInitialized == false) {
      return;
    }
    switch (state) {
      case AppLifecycleState.resumed:
        initCamera();
        break;
      case AppLifecycleState.inactive:
        _controller.dispose();
        break;
      case AppLifecycleState.paused:
        _controller.dispose();
        break;
      case AppLifecycleState.detached:
        _controller.dispose();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leading: null,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                popBack();
              },
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: cameraBody());
  }

  Widget cameraBody() {
    if (Platform.isIOS) {
      return SafeArea(
        top: false,
        bottom: false,
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final view = MediaQuery.of(context);
              double width = view.size.width;
              return Stack(children: [
                Center(
                  child: Transform.scale(
                    scale: 1 /
                        (_controller.value.aspectRatio * view.size.aspectRatio),
                    alignment: Alignment.center,
                    child: Hero(
                      tag: 1,
                      child: CameraPreview(
                        _controller,
                        child: SafeArea(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: width / 1.25,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12),
                                        child:
                                            instructions(view, "Look Straight"),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12),
                                        child: instructions(
                                            view, "Consistent lighting"),
                                      ),
                                    ),
                                    Expanded(
                                      child: instructions(
                                          view, "Keep face inside oval"),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Container(
                                    width: width / 1.5,
                                    height: (width / 1.5) + 60,
                                    child: const Center(),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.greenAccent.shade700,
                                          width: 2),
                                      borderRadius: BorderRadius.all(
                                        Radius.elliptical((width / 1.5) + 110,
                                            (width / 1.5) + 210),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: view.size.width / 6,
                                height: view.size.width / 6,
                                child: TakePicture(
                                  initializeControllerFuture:
                                      _initializeControllerFuture,
                                  controller: _controller,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      );
    } else {
      return _permissionStatus == PermissionStatus.granted
          ? SafeArea(
              top: false,
              bottom: false,
              child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final view = MediaQuery.of(context);
                    double width = view.size.width;
                    return Stack(children: [
                      Center(
                        child: Transform.scale(
                          scale: 1 /
                              (_controller.value.aspectRatio *
                                  view.size.aspectRatio),
                          alignment: Alignment.center,
                          child: Hero(
                            tag: 1,
                            child: CameraPreview(
                              _controller,
                              child: SafeArea(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: width / 1.25,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 12),
                                              child: instructions(
                                                  view, "Look Straight"),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 12),
                                              child: instructions(
                                                  view, "Consistent lighting"),
                                            ),
                                          ),
                                          Expanded(
                                            child: instructions(
                                                view, "Keep face inside oval"),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Container(
                                          width: width / 1.5,
                                          height: (width / 1.5) + 60,
                                          child: const Center(),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color:
                                                    Colors.greenAccent.shade700,
                                                width: 2),
                                            borderRadius: BorderRadius.all(
                                              Radius.elliptical(
                                                  (width / 1.5) + 110,
                                                  (width / 1.5) + 210),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: view.size.width / 6,
                                      height: view.size.width / 6,
                                      child: TakePicture(
                                        initializeControllerFuture:
                                            _initializeControllerFuture,
                                        controller: _controller,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          : Container();
    }
  }

  void popBack() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
    _controller.dispose();
  }
}

class TakePicture extends StatelessWidget {
  const TakePicture({
    Key? key,
    required Future<void> initializeControllerFuture,
    required CameraController controller,
  })  : _initializeControllerFuture = initializeControllerFuture,
        _controller = controller,
        super(key: key);

  final Future<void> _initializeControllerFuture;
  final CameraController _controller;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        check().then((internet) async {
          if (internet != null && internet) {
            try {
              // Attempt to take a picture and get the file `image`
              // where it was saved.
              await scanPhoto(context);
            } catch (e) {}
          } else {
            showToast("There is no internet connection!", isError: true);
          }
        });
      },
      style: OutlinedButton.styleFrom(
        shape: const StadiumBorder(),
        side: const BorderSide(
            width: 4, color: Colors.white, style: BorderStyle.solid),
      ),
      child: const Center(),
    );
  }

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  Future<void> scanPhoto(BuildContext context) async {
    showAlertDialog(context);
    await _initializeControllerFuture;
    final image = await _controller.takePicture();
    // List<int> imageBytes = await image.readAsBytes();

    Uint8List imageBytes = await image.readAsBytes(); //convert to bytes
    img.Image? originalImage = img.decodeImage(imageBytes);
    img.Image fixedImage = img.flipHorizontal(originalImage!);
    File file = File(image.path);
    File fixedFile = await file.writeAsBytes(
      img.encodeJpg(fixedImage),
      flush: true,
    );
    String path = fixedFile.path;

    // If the picture was taken, display it on a new screen.
    Navigator.pop(context);
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ScanResultsScreen(
            // Pass the automatically generated path to
            // the DisplayPictureScreen widget.
            imagePath: path,
            // imageBase64: base64string,
          );
        },
      ),
    );
  }
}
