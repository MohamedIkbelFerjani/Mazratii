import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:mazratii/views/Logout.dart';
import 'package:mazratii/views/OurPlants.dart';
import 'package:mazratii/views/weather.dart';

import '../FirstPageEver.dart';
import '../maps.dart';
import '../plants.dart';
import '../spacesview.dart';

class HidenDrawer extends StatefulWidget {
  final int initPositionSelected;

  const HidenDrawer({Key? key, required this.initPositionSelected});

  @override
  State<HidenDrawer> createState() => _HidenDrawerState();
}

class _HidenDrawerState extends State<HidenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];
  final mytextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white);
  final mytextStylee = TextStyle(
      fontWeight: FontWeight.normal, fontSize: 30, color: Colors.white);
  bool _isMapActive = false; // Track map interaction state

  @override
  void initState() {
    super.initState();
    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'الرئيسية',
          baseStyle: mytextStylee,
          selectedStyle: mytextStyle,
        ),
        Firstpageever(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'مساحاتك',
          baseStyle: mytextStylee,
          selectedStyle: mytextStyle,
        ),
        SpacesView(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'كل النباتات',
          baseStyle: mytextStylee,
          selectedStyle: mytextStyle,
        ),
        OurPants(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'الخريطة',
          baseStyle: mytextStylee,
          selectedStyle: mytextStyle,
        ),
        Maps(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'الطقس',
          baseStyle: mytextStylee,
          selectedStyle: mytextStyle,
        ),
        WetherView(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'تسجيل الخروج',
          baseStyle: mytextStylee,
          selectedStyle: mytextStyle,
        ),
        LogoutView(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: Colors.green,
      screens: _pages,
      initPositionSelected: widget.initPositionSelected,
    );
  }
}
