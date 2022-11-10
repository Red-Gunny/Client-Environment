import 'package:flutter/material.dart';

import '../../../models/custom_drink.dart';
import 'custom_drink_detail.dart';

/// 사진이랑 리스트 속 간단 정보를 나타내기 위한... 틀
/// 실제 간단정보 text는 custom_drink_detail로 표현
class CustomDrinkItem extends StatelessWidget {

  final CustomDrinkModel customDrink;

  /// 생성자
  const CustomDrinkItem({Key? key, required this.customDrink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135.0,
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          /// 칵테일 사진
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              customDrink.urlToImg!,    // !는 null체킹 (String? to String)
              width: 115,
              height: 115,
              fit: BoxFit.cover
            ),
          ),
          const SizedBox(width:16.0),
          CustomDrinkDetail(customDrink: customDrink),
        ]
      )
    );
  }
}
