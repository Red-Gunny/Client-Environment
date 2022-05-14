import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'theme.dart';
import 'package:graduation_project/screens/main_screens.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();    /// runApp()전에 카메라 관련 초기화 작업
  final cameras = await availableCameras();     /// 디바이스에서 사용 가능한 카메라 리스트를 가져온다.
  final firstCamera = cameras.first;            /// 위에 카메라 리스트에서 구체적으로 1개를 가져온다.

  runApp(GraduationApp(
      firstCamera: firstCamera
  ));
}

class GraduationApp extends StatelessWidget {
  final firstCamera;
  const GraduationApp({
    Key? key,
    this.firstCamera,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'liquor_team',
      debugShowCheckedModeBanner: false,
      home: MainScreens(
          firstCamera: this.firstCamera,
      ),
      theme: theme(),
    );
  }
}
