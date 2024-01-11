import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';

import '../models/home_tab_item/tab_item.dart';

class HomeViewModel extends ChangeNotifier implements TickerProvider {
  late TabController tabController;
  final List<TabItem> tabs = [
    const TabItem('VÍDEOS'),
    const TabItem('ARTIGOS'),
    const TabItem('CITAÇÕES'),
  ];

  final Color tabBarBackgroundColor = const Color(0xFF996666);
  final Color selectedTabColor = Colors.black;
  final Color unselectedTabColor = Colors.white;

  HomeViewModel() {
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    notifyListeners();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick, debugLabel: 'ticker');
  }
}
