import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persediaan_barang/pages/about_page.dart';
import 'package:persediaan_barang/pages/home_page.dart';
import 'package:persediaan_barang/pages/setting_page.dart';
import 'package:persediaan_barang/pages/training_page.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class FoundationPage extends StatelessWidget {
  FoundationPage({Key? key}) : super(key: key);

  final _controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style1,
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      const TrainingPage(),
      SettingPage(),
      const AboutPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.list_dash),
        title: ("Penjualan"),
        activeColorPrimary: CupertinoColors.systemGreen,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.settings),
        title: ("Settings"),
        activeColorPrimary: CupertinoColors.activeOrange,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.info),
        title: ("Tentang"),
        activeColorPrimary: CupertinoColors.systemPurple,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}
