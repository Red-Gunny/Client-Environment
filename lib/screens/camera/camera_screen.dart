import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:camera/camera.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import '../../models/camera_response.dart';
import '../information_result/liquor_information.dart';
import '../../util/config.dart';

import '../../models/camera_liquor.dart';

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;
  const CameraScreen({Key? key, required this.camera}) : super(key: key);   /// 생성자
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
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
    final options = BaseOptions(               /// Dio 라이브러리 사용하기 위한 초기화
      contentType: yoloContentType,
      baseUrl: yoloServerUrl,
      connectTimeout: yoloConnectTimeout,
      receiveTimeout: yoloReceiveTimeout,
    );
    yoloDio = Dio(options);                   /// Dio 객체 생성.
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(''), backgroundColor: Colors.transparent, elevation: 0.0),  /// 투명하게 해서 카메라 preview가 전체 되도록 설정
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: _showCameraPreview(),       /// 카메라 미리보기화면 보여주는 함수 (Extracted)
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();                                      ///  사진이 찍히는 부분
            var imageFormData = await _createImageToHttpForm(key : "file", image : image);      /// 사진을 Http Form 데이터 형식으로 변환.
            ProgressDialog progressDialog = ProgressDialog(context: context);           /// 로딩 중 화면을 위한 객체 생성
            progressDialog.show(max:100, msg: '사진을 분석 중입니다...', completed: Completed(completedMsg: '찾았다!', closedDelay: 2000));
            final yoloResponse = await yoloDio.post(yoloServerPath, data: imageFormData);   /// YOLO 서버에 이미지 전송
            progressDialog.close();                                                /// 진행 중 화면 닫기
            Map<String, dynamic> responseMap = yoloResponse.data;                 /// 결과를 Map에 담고(type casting)
            final parsedYoloResponse = CameraResponse.fromJson(responseMap);      /// Map을 OneResponse로 바꿈

            if (parsedYoloResponse.size! > 1) {             /// 여러 개일 때 선택받아야함
              await _showChoiceDialog(context, liquors: parsedYoloResponse.liquors!);
            } else if (parsedYoloResponse.size! == 1) {     /// 1개일 때는 다이렉트 이동
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) =>
                        LiquorInformation(
                            liquorName: parsedYoloResponse.liquors![0].name.toString()
                        )
                )
              );
            } else {  // 에러 처리 필요

            }
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

  /// #########  [함수 추출부] ############

  /// [카메라 프리뷰 보여주는 함수]
  /// 카메라 preview가 나타나기 전 까지 contoller가 초기화 되도록 반드시 기다려야한다.
  /// controller 초기화가 끝날 때까지 FutureBuilder(로딩 스피너를 보여주기 위한 목적의)를 이용해라.
  FutureBuilder<void> _showCameraPreview() {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final mediaSize = MediaQuery.of(context).size;
          final scale = 1 / (_controller.value.aspectRatio * mediaSize.aspectRatio);
          return ClipRect(
            clipper: _MediaSizeClipper(mediaSize),
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.topCenter,
              child: CameraPreview(_controller),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  /// HTTP 요청 메세지 만드는 함수
  Future<FormData> _createImageToHttpForm({required String key, required XFile image}) async =>
      FormData.fromMap({key: await MultipartFile.fromFile(image.path)});


  /// 팝업 보여주는 함수
  Future<dynamic> _showChoiceDialog(BuildContext context, {required List<CameraLiquor> liquors}) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            elevation: 10.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            title: const Text("여러 개가 나왔어요 !"),
            content: getLiquorMenuElement(liquors : liquors),
          ),
    );
  }

  /// 팝업 리스트 내 함수 추출
  Widget getLiquorMenuElement({required List<CameraLiquor> liquors}) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(2, 20, 2, 20),      /// 끝에 마진 줌
      child: Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,       /// 리스트의 요소들 간 간격을 동등하게 배치함.
            children: <Widget>[
              Expanded(                                               /// 부모의 남는 부분을 전부 채울 때
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: liquors.length,
                    itemBuilder: (BuildContext context, int index) {      /// 이제 요소 출력하는 부분
                      return ListTile(
                        leading: CircleAvatar(backgroundImage: NetworkImage("$imageServerUrl/${liquors[index].name}.jpg")),
                        title: Text(liquors[index].name.toString()),
                        onTap: () async => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) =>
                              LiquorInformation(liquorName: liquors[index].name.toString())
                          )
                        ),
                      );
                    },
                    separatorBuilder: (context,index) {                 /// 구분선 표현하는 부분
                      return Divider();
                    },
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const <Widget> [
                  Icon(Icons.cancel),
                ]
              )
            ],
          )
        )
      )
    );
  }

}


/// 카메라 프리뷰 사이즈 조정 관련 클래스
class _MediaSizeClipper extends CustomClipper<Rect> {
  final Size mediaSize;
  const _MediaSizeClipper(this.mediaSize);

  @override
  Rect getClip(Size size) => Rect.fromLTWH(0, 0, mediaSize.width, mediaSize.height);

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}