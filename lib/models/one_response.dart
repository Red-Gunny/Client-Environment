class OneResponse {
  double? accuracy;
  int? index;
  String? name;

  OneResponse({this.accuracy, this.index, this.name});



  OneResponse.fromJson(Map<String, dynamic> json) {
    accuracy = json['accuracy'];
    index = json['index'];
    name = json['name'];
  }

}