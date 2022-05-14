class CameraResponse {
  List<Liquors>? liquors;
  int? size;

  CameraResponse({this.liquors, this.size});

  CameraResponse.fromJson(Map<dynamic, dynamic> json) {
    if (json['liquors'] != null) {
      liquors = <Liquors>[];
      json['liquors'].forEach((v) {
        liquors!.add(new Liquors.fromJson(v));
      });
    }
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.liquors != null) {
      data['liquors'] = this.liquors!.map((v) => v.toJson()).toList();
    }
    data['size'] = this.size;
    return data;
  }
}

class Liquors {
  double? accuracy;
  int? index;
  String? name;

  Liquors({this.accuracy, this.index, this.name});

  Liquors.fromJson(Map<dynamic, dynamic> json) {
    accuracy = json['accuracy'];
    index = json['index'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accuracy'] = this.accuracy;
    data['index'] = this.index;
    data['name'] = this.name;
    return data;
  }
}