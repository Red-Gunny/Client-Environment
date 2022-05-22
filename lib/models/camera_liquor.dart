class CameraLiquor {
  double? accuracy;
  int? index;
  String? name;

  CameraLiquor({this.accuracy, this.index, this.name});

  CameraLiquor.fromJson(Map<String, dynamic> json) {
    accuracy = json['accuracy'];
    index = json['index'];
    name = json['name'];
  }
}