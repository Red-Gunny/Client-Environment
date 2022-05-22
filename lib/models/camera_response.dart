import 'camera_liquor.dart';

class CameraResponse {
  List<CameraLiquor>? liquors;
  int? size;

  CameraResponse({this.liquors, this.size});

  CameraResponse.fromJson(Map<dynamic, dynamic> json) {
    if(json['size']==0) {
      liquors = [];
      size = 0;
    }
    if (json['liquors'] != null && json['size']!=0) {    // liquors가 null이 아니면
      liquors = <CameraLiquor>[];     // 배열? 선언
      json['liquors'].forEach((v) {   // 들어있는거마다 담아!
        liquors!.add(CameraLiquor.fromJson(v));
      });
    }
    size = json['size'];
  }

}
