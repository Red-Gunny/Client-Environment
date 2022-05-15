import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'camera/camera_screen.dart';
import 'custom_drinks/custom_drinks.dart';
import 'drink_list/drink_list.dart';
import 'near_liquor_shop/near_liquor_shop.dart';

import 'information_result/liquor_information.dart';

class MainScreens extends StatefulWidget {
  final firstCamera;

  MainScreens({
    Key? key,
    required this.firstCamera,
  }) : super(key: key);

  @override
  _MainScreensState createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          CameraScreen(camera: widget.firstCamera),
          const LiquorInformation(
            liquorName: "Kahlua",
          ),
          CustomDrinks(),
          NearLiquorShop(liquorName: "Tlqkf"),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              label: '라벨 인식', icon :Icon(CupertinoIcons.camera_viewfinder)),
          BottomNavigationBarItem(
              label: '목록 확인', icon :Icon(CupertinoIcons.list_bullet)
          ),
          BottomNavigationBarItem(
              label: '나만의 레시피', icon :Icon(CupertinoIcons.group)
          ),
          BottomNavigationBarItem(
              label: '주변 샵', icon :Icon(CupertinoIcons.placemark)
          ),
        ],
      ),
    );
  }
}
