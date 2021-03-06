import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_redux/ui/hoem_screen.dart';
import 'package:flutter_wanandroid_redux/ui/project_screen.dart';
import 'package:flutter_wanandroid_redux/ui/setting_screen.dart';
import 'package:flutter_wanandroid_redux/widget/home_bottom_bar.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  int _selectedTab = 0;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Widget _buildContent() {
    return Column(
      children: <Widget>[
        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              HomeScreen(),
              ProjectScreen(),
              SettingScreen(),
            ],
          ),
        ),
        HomeBottomBar(
          selectedTab: _selectedTab,
          onTabChanged: (selectedTab) {
            setState(() {
              _selectedTab = selectedTab;
              _tabController.index = _selectedTab;
            });
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(),
    );
  }
}
