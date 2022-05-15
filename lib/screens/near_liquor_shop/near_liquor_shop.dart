import 'package:flutter/material.dart';

class NearLiquorShop extends StatelessWidget {
  final String liquorName;

  const NearLiquorShop({
    required this.liquorName,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(liquorName),
      ),
      body: Text(liquorName),
    );
  }
}
