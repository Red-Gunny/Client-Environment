import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:camera/camera.dart';

import '../../models/camera_response.dart';
import '../information_result/liquor_information.dart';
import '../../util/config.dart';

// 중간발표용 임시
import '../../models/one_response.dart';

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late Dio yoloDio;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
    final options = BaseOptions(
      contentType: yoloContentType,
      baseUrl: yoloServerUrl,
      connectTimeout: yoloConnectTimeout,
      receiveTimeout: yoloReceiveTimeout,
    );
    yoloDio = Dio(options);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('Take a picture')),
      extendBody: true,
      /// 2. body
      /// 카메라 preview가 나타나기 전 까지 contoller가 초기화 되도록 반드시 기다려야한다.
      /// controller 초기화가 끝날 때까지 FutureBuilder(로딩 스피너를 보여주기 위한 목적의)를 이용해라.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      /// 3. floatingActionButtion (버튼 눌렀을 때 무슨 동작을 해야할까)
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();          /// ★★★★★ 사진이 찍히는 부분 ★★★★★
            var formData = FormData.fromMap({                       /// HTTP 요청 메세지 만드는 과정
              'file': await MultipartFile.fromFile(image.path),
            });
            final yoloResponse = await yoloDio.post(yoloServerPath, data: formData);   /// YOLO 서버에 이미지 전송
            Map<String, dynamic> responseMap = yoloResponse.data;                 /// 결과를 Map에 담고             [YOLO 서버 응답]
            final parsedYoloResponse = OneResponse.fromJson(responseMap);         /// Map을 OneResponse로 바꿈     [YOLO 서버 응답]
            await Navigator.of(context).push(                                   /// 술 정보 페이지로 화면 이동  (비동기에서 context 쓰지 말라는데 왜?)
              MaterialPageRoute(
                  builder: (context) => LiquorInformation(liquorName: parsedYoloResponse.name.toString())
              )
            );
          } catch (e) {
            print(e);
          }
        }, // onPressed
        label:  const Text('촬영'),
        icon: const Icon(Icons.camera),
        backgroundColor: Colors.grey,
      ),
    );
  }
}
