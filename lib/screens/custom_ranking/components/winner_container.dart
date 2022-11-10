import 'package:flutter/material.dart';

import '../../../util/constants.dart';

class WinnerContainer extends StatelessWidget {
  final bool isFirst;
  final Color color;
  final int winnerPosition;
  final String winnerName;
  final String rank;
  final double height;

  /// 생성자
  const WinnerContainer(
      {Key? key,
        required this.isFirst,
        required this.color,
        required this.winnerPosition,
        required this.winnerName,
        required this.rank,
        required this.height
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(                                       /// 안쪽 여백 지정
      padding: const EdgeInsets.all(10.0),                /// 4방향 전부 10만큼
      child: Stack(                                         /// 이거 겹쳐서 보일 수 있게 함
        children: [
          Padding(                                          /// 안쪽 여백 지정
            padding: const EdgeInsets.only(top: 60.0),
            child: Center(
              child: Container(
                height: height??150.0,
                width: 100.0,
                decoration: const BoxDecoration(
                    color: calculatorButton,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0))
                ),
              ),
            ),
          ),
          Center(
            child: Stack(
              children: [
                Image.asset('assets/crown.png', height: 60.0, width: 100.0,),
                Padding(
                  padding: const EdgeInsets.only(top:55.0),
                  child: Container(
                    height: 60.0,
                    width: 60.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.red),
                        image: const DecorationImage(
                            image: AssetImage('assets/man.png'),
                            fit: BoxFit.fill
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 110.0, left: 40.0),
                  child: Container(
                    height: 20.0,
                    width: 20.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: const Text('1', style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 140.0, left: 10.0),
            child: Column(
                children: [
                  Text(winnerName??'Emma Aria', style: const TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),),
                  Text(rank??'2445', style: TextStyle(color: color??Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),),
                ]
            ),
          )
        ],
      ),
    );
  }
}