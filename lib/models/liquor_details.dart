class LiquorDetailsModel {
  String? englishName;
  String? koreanName;
  String? description;
  String? hashtag;
  String? imgUrl;

  LiquorDetailsModel(
      {this.englishName,
        this.koreanName,
        this.description,
        this.hashtag,
        this.imgUrl});

  LiquorDetailsModel.fromJson(Map<dynamic, dynamic> json) {
    englishName = json['englishName'];
    koreanName = json['koreanName'];
    description = json['description'];
    hashtag = json['hashtag'];
    imgUrl = json['img_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['englishName'] = this.englishName;
    data['koreanName'] = this.koreanName;
    data['description'] = this.description;
    data['hashtag'] = this.hashtag;
    data['img_url'] = this.imgUrl;
    return data;
  }
}