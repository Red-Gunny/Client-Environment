import 'package:flutter/cupertino.dart';

import '../../../models/custom_drink.dart';
import '../../../theme.dart';

/// 리스트 속 내용을 표현함
class CustomDrinkDetail extends StatelessWidget {
  final CustomDrinkModel customDrink;

  const CustomDrinkDetail({Key? key, required this.customDrink});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(customDrink.title!, style: textTheme().bodyText1),     /// 술 제목
          const SizedBox(height: 4.0),
          //Text('${customDrink.address} • ${customDrink.publishedAt}'),    /// 해시태그
          //const SizedBox(height: 4.0),
          Text(customDrink.author!, style: textTheme().headline2),      /// 술 만든이
          const Spacer(),
          /// 댓글 & 좋아요 수 간략히 표현하는
          Row(
            mainAxisAlignment: MainAxisAlignment.end,   /// 끝에 다 배치하겠음
            children: [
              /// 댓글
              Visibility(
                visible: customDrink.commentsCount! > 0,      /// 없으면 안 보임
                child: _buildIcons(
                  customDrink.commentsCount!,
                  CupertinoIcons.chat_bubble_2,
                ),
              ),
              const SizedBox(width: 8.0),
              /// 좋아요
              Visibility(
                visible: customDrink.heartCount! > 0,
                child: _buildIcons(
                  customDrink.heartCount!,
                  CupertinoIcons.heart,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildIcons(int count, IconData iconData) {
    return Row(
      children: [
        Icon(iconData, size: 14.0),
        const SizedBox(width: 4.0),
        Text('$count'),
      ],
    );
  }
}
