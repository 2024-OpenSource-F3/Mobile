import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:image/image.dart' as img;

class RatingScreen extends StatefulWidget {
  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late List<CameraDescription> cameras;
  bool _isCameraInitialized = false;
  bool _isLoading = true;

  double? _confidence;
  String? _name;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    try {
      cameras = await availableCameras();
      _controller = CameraController(
        cameras[0],
        ResolutionPreset.max, // 해상도를 높이기 위해 ResolutionPreset.high 사용
      );

      _initializeControllerFuture = _controller.initialize();
      await _initializeControllerFuture;

      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Camera initialization error: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _sendImageToServer(String imagePath) async {
    try {
      // 이미지를 읽어와서 압축
      File imageFile = File(imagePath);
      List<int> imageBytes = await imageFile.readAsBytes();
      img.Image? originalImage = img.decodeImage(imageBytes);

      if (originalImage == null) {
        print('Error decoding image');
        return;
      }

      // 압축된 이미지 생성 (예: 85% 품질로)
      List<int> compressedImageBytes = img.encodeJpg(originalImage, quality: 85);
      File compressedImageFile = File('${imageFile.parent.path}/compressed_${basename(imageFile.path)}')
        ..writeAsBytesSync(compressedImageBytes);

      Dio dio = Dio();
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(compressedImageFile.path, filename: basename(compressedImageFile.path)),
      });

      Response response = await dio.post('http://192.168.30.105:4740/predict', data: formData);

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
        print(response.data);

        // 서버 응답 처리
        if (response.data is List && response.data.isNotEmpty) {
          var result = response.data[0];
          setState(() {
            _confidence = result['confidence'];
            _name = result['name'];
            print("response success");
          });
        }
      } else {
        print('Failed to upload image');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('꼬기꼬기', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : _isCameraInitialized
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300.0,
              height: 400.0,
              child: CameraPreview(_controller),
            ),
            SizedBox(height: 20.0),
            ElevatedButton.icon(
              onPressed: () async {
                try {
                  await _initializeControllerFuture;
                  final image = await _controller.takePicture();
                  if (!mounted) return;

                  await showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Captured Image'),
                      content: Image.file(File(image.path)),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );

                  // 서버로 이미지 전송
                  await _sendImageToServer(image.path);
                } catch (e) {
                  print(e);
                }
              },
              icon: Icon(Icons.camera_alt),
              label: Text('고기 등급 확인'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[100],
                foregroundColor: Colors.black,
              ),
            ),
            SizedBox(height: 20.0),
            if (_confidence != null && _name != null)
              Column(
                children: [
                  Text('Confidence: ${(_confidence! * 100).toStringAsFixed(2)}%'),
                  Text('Name: $_name'),
                ],
              ),
          ],
        )
            : Text('카메라 초기화 실패'),
      ),
    );
  }
}
