import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/custom_drink.dart';
import 'components/custom_drink_item.dart';

class CustomDrinkList extends StatefulWidget {
  const CustomDrinkList({Key? key}) : super(key: key);

  @override
  State<CustomDrinkList> createState() => _CustomDrinkListState();
}

class _CustomDrinkListState extends State<CustomDrinkList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: const [
              Text('레시피 게시판', style: TextStyle(fontSize:22, fontWeight: FontWeight.bold, color: Colors.black87)),
              SizedBox(width: 4.0),
            ],
          ),
          actions: [
            IconButton(icon: const Icon(CupertinoIcons.search, color: Colors.black87), onPressed: () {}),
            IconButton(icon: const Icon(CupertinoIcons.pencil, color: Colors.black87), onPressed: () {})
          ],
          bottom: const PreferredSize(
              preferredSize: Size.fromHeight(0.5),
              child: Divider(thickness: 0.5, height: 0.5, color: Colors.grey)
          ),
          backgroundColor: Colors.white,
        ),
        body: ListView.separated(
          separatorBuilder: (context, index) => const Divider(height: 0, indent: 16, endIndent: 16, color: Colors.grey,),
          itemBuilder: (context, index) {
            return CustomDrinkItem(
              customDrink: drinkList[index],
            );
          },
          itemCount: drinkList.length,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
