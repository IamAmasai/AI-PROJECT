dart
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Face Recognition App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CameraScreen(),
    );
  }
}

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Face Recognition')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CameraPreviewScreen(camera: _controller)),
                );
              },
              child: Text('Take Picture'),
            ),
            ElevatedButton(
              onPressed: () {
                _pickImageFromGallery();
              },
              child: Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }

  void _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Send the selected image to the server for face recognition and classification
      classifyImage(pickedFile.path);
    } else {
      print('No image selected');
    }
  }

  void classifyImage(String imagePath) async {
    // Send the image to the server for classification
    var url = Uri.parse('http://your-server-url/recognize');
    var request = http.MultipartRequest('POST', url)
      ..files.add(await http.MultipartFile.fromPath('image', imagePath));
    var response = await request.send();
    if (response.statusCode == 200) {
      var jsonResponse = await response.stream.bytesToString();
      // Process the classification results received from the server
      Map<String, dynamic> data = json.decode(jsonResponse);
      // Display the classification results in the app
      print(data['predictions']);
    } else {
      print('Failed to send image for classification');
    }
  }
}

class CameraPreviewScreen extends StatefulWidget {
  final CameraController camera;

  const CameraPreviewScreen({Key key, this.camera}) : super(key: key);

  @override
  _CameraPreviewScreenState createState() => _CameraPreviewScreenState();
}

class _CameraPreviewScreenState extends State<CameraPreviewScreen> {
  @override
  void dispose() {
    widget.camera.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera Preview')),
      body: FutureBuilder<void>(
        future: widget.camera.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(widget.camera);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            await widget.camera.initialize();
            XFile imageFile = await widget.camera.takePicture();
            // Send the imageFile to the server for face recognition and classification
            classifyImage(imageFile.path);
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }

  void (String imagePath) async {
    // Send the image to the server for classification
    await sendImageForClassification(imagePath);
  }

  Future<void> sendImageForClassification(String imagePath) async {
    var url = Uri.parse('http://your-server-url/recognize');
    var request = http.MultipartRequest('POST', url)
      ..files.add(await http.MultipartFile.fromPath('image', imagePath));
    var response = await request.send();
    if (response.statusCode == 200) {
      var jsonResponse = await response.stream.bytesToString();
      // Process the classification results received from the server
      Map<String, dynamic> data = json.decode(jsonResponse);
      // Display the classification results in the app
      print(data['predictions']);
    } else {
      print('Failed to send image for classification');
    }
  }
    // Send the image to the server for classification
    var url = Uri.parse('http://your-server-url/recognize');
    var request = http.MultipartRequest('POST', url)
      ..files.add(await http.MultipartFile.fromPath('image', imagePath));
    var response = await request.send();
    if (response.statusCode == 200) {
      var jsonResponse = await response.stream.bytesToString();
      // Process the classification results received from the server
      Map<String, dynamic> data = json.decode(jsonResponse);
      // Display the classification results in the app
      print(data['predictions']);
    } else {
      print('Failed to send image for classification');
    }
  }
}