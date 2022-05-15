import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/models/one_response.dart';

import '../../models/camera_response.dart';
import '../information_result/liquor_information.dart';
import '../../util/config.dart';
import '../near_liquor_shop/near_liquor_shop.dart';

// A screen that allows users to take a picture using a given camera.
class CameraScreen extends StatefulWidget {
  const CameraScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  _CameraScreen createState() => _CameraScreen();
}

class _CameraScreen extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late Dio dio;


  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();

    dio = Dio();
    dio.options.contentType = 'multipart/form-data';
    dio.options.baseUrl = yoloServerUrl;
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /*Future<dynamic> getLabelAnalysis(var formData) async {
    final response = await dio.post('/test', data: formData);
    Map cameraMap = jsonDecode(response.data.toString());
    OneResponse cameraResponse = OneResponse.fromJson(cameraMap);
    return cameraResponse.name.toString();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('Take a picture')),
      extendBody: true,
      /// 2. body 부분
      /// 카메라 preview가 나타나기 전 까지 contoller가 초기화 될 때까지 반드시 기다려야한다.
      /// controller가 초기화 끝날 때까지 FutureBuilder(로딩 스피너를 보여주기 위한 목적의)를 이용해라.
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
            var formData = FormData.fromMap({                       /// HTTP 요청 메세지 만드는 중
              'file': await MultipartFile.fromFile(image.path),
            });
            final response = await dio.post('/test', data: formData).then(
                (value) {
                  if (value == null) {
                    print('value');
                    return;
                  }
                  Map<String, dynamic> cameraMap = jsonDecode(value.data.toString());
                  print(cameraMap);
                  OneResponse cameraResponse = OneResponse.fromJson(cameraMap);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NearLiquorShop(liquorName: cameraResponse.name.toString())));
                }
            );
          } catch (e) {
            print(e);
          }
        },
        label:  const Text('촬영'),
        icon: const Icon(Icons.camera),
        backgroundColor: Colors.grey,
      ),
    );
  }
}

/**
 *
 *
 * //Map cameraMap = jsonDecode(yoloResponse.data.toString());
    //OneResponse cameraResult = OneResponse.fromJson(cameraMap);

    //Navigator.of(context).push(MaterialPageRoute(
    //builder: (context) => LiquorInformation(
    //liquorName: cameraResult.name.toString())));


    /*final result = await dio.post('/test', data: formData);
    if (result.statusCode == 200) {
    Map cameraMap = jsonDecode(re.data.toString());
    OneResponse cameraResponse = OneResponse.fromJson(cameraMap);

    print("Tlqkf${cameraResponse.name}");

    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => LiquorInformation(
    liquorName: cameraResponse.name.toString(),
    )
    ),
    );
    }*/


    /*
    await dio.post('/test', data: formData).then((response) {
    Map cameraMap = jsonDecode(response.data.toString());
    OneResponse cameraResponse = OneResponse.fromJson(cameraMap);

    print("Tlqkf${cameraResponse.name}");

    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => LiquorInformation(
    liquorName: cameraResponse.name.toString(),
    )
    ),
    );
    });*/   ///  서버로 가긴 했어



    print("post before");
    await dio.post('/test', data: formData).then(
    (yoloResponse) {

    print("then in");

    Map cameraMap = jsonDecode(yoloResponse.data.toString());
    OneResponse cameraResult = OneResponse.fromJson(cameraMap);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LiquorInformation(liquorName: cameraResult.name.toString())));
    }
    );  // 다음 작업으로 안 넘어가.
 */