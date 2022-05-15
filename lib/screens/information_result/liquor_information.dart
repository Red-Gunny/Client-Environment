import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../util/constants.dart';
import '../../util/config.dart';
import '../../models/liquor_details.dart';

class LiquorInformation extends StatefulWidget {
  final String liquorName;

  const LiquorInformation({
    Key? key,
    required this.liquorName,
  }) : super(key: key);

  @override
  State<LiquorInformation> createState() => _LiquorInformationState();
}

class _LiquorInformationState extends State<LiquorInformation> {

  late Dio dbServer;
  late Dio imageStorage;
  late Future<LiquorDetailsModel> liquorDetails;

  late final String liquorName;
  late final String hastag;
  late final String Description;
  late final String engName;
  late final String imgUrl;

  Future<LiquorDetailsModel> requestLiquorDetails() async {
    var url = Uri.parse("$springServerUrl/${widget.liquorName}");     // URL 만들엇어
    final response = await http.get(url);     // 보내 씨발년아

    if (response.statusCode == 200) {
      // 만약 서버가 OK 응답을 반환하면, JSON을 파싱합니다.
      return LiquorDetailsModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      // 만약 응답이 OK가 아니면, 에러를 던집니다.
      throw Exception('Failed to load post');
    }
  }



  @override
  void initState() {
    liquorDetails = requestLiquorDetails();
    
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LiquorDetailsModel>(
      future: liquorDetails,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                leading: const BackButton(color: Colors.black),
                actions: [],
              ),
              body: Column(
                children: [
                  /// [1번 child]
                  Image.network(
                    "$imageServerUrl/${snapshot.data!.englishName}.jpg",
                    height: MediaQuery.of(context).size.height * 0.4,
                    fit: BoxFit.cover,
                  ),

                  /// [2번 child]
                  ///
                  ///
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
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                    snapshot.data!.koreanName.toString(),
                                    style: Theme.of(context).textTheme.headline6,
                                  )
                              ),
                              const SizedBox(width: defaultPadding),
                              Text(
                                snapshot.data!.hashtag.toString(),
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: defaultPadding),
                            child:  Text(snapshot.data!.description.toString()),
                          )
                        ],
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


/*

dbServer = Dio();
    dbServer.options.contentType = 'application/json';
    dbServer.options.baseUrl = springServerUrl;
    dbServer.options.connectTimeout = 10000;
    dbServer.options.receiveTimeout = 10000;

    String path = "/${widget.liquorName}";
    final response = dbServer.get(path).then(
        (value) {
          Map<String, dynamic> liquorMap = jsonDecode(value.data.toString());
          liquorDetails = LiquorDetailsModel.fromJson(liquorMap);
        }
    );
 */