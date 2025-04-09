import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class SignCam extends StatefulWidget {
  final CameraDescription camera;

  const SignCam({Key? key, required this.camera}) : super(key: key);

  @override
  _SignCamState createState() => _SignCamState();
}

class _SignCamState extends State<SignCam> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  String detectedText = "Waiting for sign..."; // Placeholder for AI detection result

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Mock: Replace this with your AI model processing logic
  void detectSignFromCamera() {
    // Here, you'd pass frames from the camera to your AI model and update the UI
    setState(() {
      detectedText = "Hello"; // Example result from AI
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Live Sign Detection')),
      body: Column(
        children: [
          // 70% Camera Preview
          Expanded(
            flex: 7,
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),

          // 30% Translation Panel
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Colors.grey[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Translation",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Text(
                    detectedText,
                    style: TextStyle(fontSize: 24, color: Colors.blueAccent),
                  ),
                  
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
