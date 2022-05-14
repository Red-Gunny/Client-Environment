import 'dart:convert';

import 'package:dio/dio.dart';
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
  late LiquorDetailsModel liquorDetails;

  @override
  void initState() async {
    dbServer = Dio();
    dbServer.options.contentType = 'application/json';
    dbServer.options.baseUrl = springServerUrl;
    dbServer.options.connectTimeout = 10000;
    dbServer.options.receiveTimeout = 10000;

    String path = "/${widget.liquorName}";
    final response = await dbServer.get(path);

    Map liquorMap = jsonDecode(response.data.toString());
    liquorDetails = LiquorDetailsModel.fromJson(liquorMap);
  }

  @override
  Widget build(BuildContext context) {
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
            liquorDetails.imgUrl.toString(),
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
                          liquorDetails.koreanName.toString(),
                          style: Theme.of(context).textTheme.headline6,
                        )
                      ),
                      const SizedBox(width: defaultPadding),
                      Text(
                        liquorDetails.hashtag.toString(),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: defaultPadding),
                    child:  Text(liquorDetails.description.toString()),
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}