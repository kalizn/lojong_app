import 'package:flutter/material.dart';

import '../../models/home/tab_item.dart';
import '../../utils/constants.dart';

class HomeViewModel extends ChangeNotifier {
  late TabController tabController;
  final List<TabItem> tabs = [
    const TabItem('VÍDEOS', 0),
    const TabItem('ARTIGOS', 1),
    const TabItem('CITAÇÕES', 2),
  ];

  final Color tabBarBackgroundColor = kSecondaryColor;
  final Color selectedTabColor = Colors.black;
  final Color unselectedTabColor = Colors.white;

  final VoidCallback onTabSelectionChanged;

  HomeViewModel({required TickerProvider vsync, required this.onTabSelectionChanged}) {
    tabController = TabController(length: tabs.length, vsync: vsync);
    tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    notifyListeners();
    onTabSelectionChanged();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
