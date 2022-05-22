import 'camera_liquor.dart';

class CameraResponse {
  List<CameraLiquor>? liquors;
  int? size;

  CameraResponse({this.liquors, this.size});

  CameraResponse.fromJson(Map<dynamic, dynamic> json) {
    if (json['liquors'] != null) {    // liquors가 null이 아니면
      liquors = <CameraLiquor>[];     // 배열? 선언
      json['liquors'].forEach((v) {   // 들어있는거마다 담아!
        liquors!.add(CameraLiquor.fromJson(v));
      });
    }
    size = json['size'];
  }

}
