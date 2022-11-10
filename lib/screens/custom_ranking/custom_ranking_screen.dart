import 'package:flutter/material.dart';
import '../../util/constants.dart';
import 'components/winner_container.dart';

class CustomRankingScreen extends StatelessWidget {
  const CustomRankingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: customBackground,),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: const Icon(Icons.arrow_back_ios, color: Colors.black38,),
          actions: const [Icon(Icons.grid_view, color: Colors.black38,)],
        ),
        body: SingleChildScrollView(
          child: Padding(                           /// 안쪽 여백 지정 위젯
            padding: const EdgeInsets.all(8.0),     /// 4방을 8.0만큼 여백
            child: Column(                          /// 세로로 정렬
              children: [
                /// [Column 요소 (1)] Region, National, Global 들어가는 부분.
                Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: calculatorButton
                  ),
                  child: Padding(     /// Row를 Padding으로 감쌌음.
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(                         /// 가로로 배치
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,    /// 양 사이드는 좁게, 자식 간 간격은 벌려
                      children: const [                  /// 이하 Text들을 가로로 배치하는것
                        Text('Region', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16.0),),
                        Text('National', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16.0),),
                        Text('Global', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16.0),),
                      ],
                    ),
                  ),
                ),
                /// [Column 요소 (2)] SizedBox. 컨테이너랑 크게 차이는 없으나, Column내 에서 여백을 지정하기 위한..
                SizedBox(height: 30.0,),
                /// [Column 요소 (3)] 이제 여기가 1등.. 2등.. 3등 들어가는 부여
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),      /// 여백 조정
                  child: Row(                                                 /// 가로로 배치
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,               /// 밑을 기준으로 정렬?
                    children: [
                      WinnerContainer(                        /// 2등
                        isFirst: isFirst,
                        color: color,
                        winnerPosition: winnerPosition,
                        winnerName: winnerName,
                        rank: rank,
                        height: 120,
                      ),
                      WinnerContainer(                        /// 1등
                        isFirst: true,
                        color: color,
                        winnerPosition:
                        winnerPosition,
                        winnerName: winnerName,
                        rank: rank,
                        height: null,
                      ),
                      WinnerContainer(                        /// 3등
                        isFirst: isFirst,
                        color: color,
                        winnerPosition: winnerPosition,
                        winnerName: winnerName,
                        rank: rank,
                        height: 120,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      )
    );
  }
}

class ContestantList extends StatelessWidget {
  const ContestantList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
