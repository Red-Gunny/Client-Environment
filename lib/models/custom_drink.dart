/// 사용자가 만든 CustomDirnk정보를 담음
class CustomDrinkModel {
  String? title;        /// 술 이름
  String? author;       /// 만든 사람
  String? recipe;       /// 레시피
  String? description;  /// 술 설명
  String? hashtag;      /// 해시태그
  String? urlToImg;       /// 이미지 URL
  int? heartCount;        /// 좋아요 수
  int? commentsCount;     /// 댓글 수

  /// 생성자
  CustomDrinkModel(
      {this.title,
        this.author,
        this.recipe,
        this.description,
        this.hashtag,
        this.urlToImg,
        this.heartCount,
        this.commentsCount,
      });

  CustomDrinkModel.fromJson(Map<dynamic, dynamic> json) {
    title = json['title'];
    author = json['author'];
    recipe = json['recipe'];
    description = json['description'];
    hashtag = json['hashtag'];
    urlToImg = json['urlToImg'];
  }
}

// 샘플 데이터
List<CustomDrinkModel> drinkList = [
  CustomDrinkModel(
      title: '니트 조끼',
      author: 'author_1',
      urlToImg:
      'https://github.com/flutter-coder/ui_images/blob/master/carrot_product_7.jpg?raw=true',
      heartCount: 8,
      commentsCount: 3),
  CustomDrinkModel(
      title: '먼나라 이웃나라 12',
      author: 'author_2',
      urlToImg:
      'https://github.com/flutter-coder/ui_images/blob/master/carrot_product_6.jpg?raw=true',
      heartCount: 3,
      commentsCount: 1),
  CustomDrinkModel(
    title: '캐나다구스 패딩조',
    author: 'author_3',
    urlToImg:
    'https://github.com/flutter-coder/ui_images/blob/master/carrot_product_5.jpg?raw=true',
    heartCount: 0,
    commentsCount: 12,
  ),
  CustomDrinkModel(
    title: '유럽 여행',
    author: 'author_4',
    urlToImg:
    'https://github.com/flutter-coder/ui_images/blob/master/carrot_product_4.jpg?raw=true',
    heartCount: 4,
    commentsCount: 11,
  ),
  CustomDrinkModel(
    title: '가죽 파우치 ',
    author: 'author_5',
    urlToImg:
    'https://github.com/flutter-coder/ui_images/blob/master/carrot_product_3.jpg?raw=true',
    heartCount: 7,
    commentsCount: 4,
  ),
  CustomDrinkModel(
    title: '노트북',
    author: 'author_6',
    urlToImg:
    'https://github.com/flutter-coder/ui_images/blob/master/carrot_product_2.jpg?raw=true',
    heartCount: 4,
    commentsCount: 0,
  ),
  CustomDrinkModel(
    title: '미개봉 아이패드',
    author: 'author_7',
    urlToImg:
    'https://github.com/flutter-coder/ui_images/blob/master/carrot_product_1.jpg?raw=true',
    heartCount: 8,
    commentsCount: 3,
  ),
];