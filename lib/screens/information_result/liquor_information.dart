import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../util/constants.dart';
import '../../util/config.dart';
import '../../models/liquor_details.dart';

// BottomNavigationBar 넣을지말지 결정 필요.
class LiquorInformation extends StatefulWidget {
  final String liquorName;                        /// 정보를 나타낼 술의 이름 (영어)

  const LiquorInformation({
    Key? key,
    required this.liquorName,
  }) : super(key: key);
  
  @override
  State<LiquorInformation> createState() => _LiquorInformationState();
}

class _LiquorInformationState extends State<LiquorInformation> {
  late Future<LiquorDetailsModel> liquorDetails;

  /// 여기 화면에 뿌릴 데이터들을 가져오는 함수
  Future<LiquorDetailsModel> requestLiquorDetails() async {
    var url = Uri.parse("$springServerUrl/${widget.liquorName}");     /// 보낼 URL 만들고
    final response = await http.get(url);                             /// DBServer로 요청 전송
    if (response.statusCode == 200) {
      return LiquorDetailsModel.fromJson(json.decode(utf8.decode(response.bodyBytes))); /// json 파싱해서 모델 반환
    } else {
      throw Exception('[requestLiquorDetails() ERROR] : status code != 200');
    }
  }

  @override
  void initState() {
    liquorDetails = requestLiquorDetails();       /// 여기 화면에 보여줄 데이터들을 위젯 초기화 시 바로 가져옴
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LiquorDetailsModel>(
      future: liquorDetails,
      builder: (context, snapshot) {
        if(snapshot.hasData) {                      /// Data 똑바로 왔으면 아래 Scaffold를 띄움
          final liquor = snapshot.data!;  //!는 not null 검증
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: const Text('찾았다'),
                leading: const BackButton(color: Colors.black),
                actions: [],
              ),
              body: Column(
                children: [
                  /// [1번 child]
                  /// 이미지 받아서 띄우는 부분
                  Image.network(
                    "$imageServerUrl/${liquor.englishName}.jpg",
                    height: MediaQuery.of(context).size.height * 0.4,
                    fit: BoxFit.cover,
                  ),
                  /// [2번 child]
                  /// 이제 술 설명에 관한 부분
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, defaultPadding),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(defaultBorderRadius * 3),
                          topRight: Radius.circular(defaultBorderRadius *3),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                      liquor.koreanName.toString(),
                                      style: Theme.of(context).textTheme.headline3,
                                    )
                                ),
                                const SizedBox(width: defaultPadding),
                                Text(
                                  liquor.hashtag.toString(),
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: defaultPadding),
                              child:  Text(liquor.description.toString()),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      }
    );
  }
}