import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/home.viewmodel.dart';

class HomeView extends StatelessWidget {
  static String routeName = '/home';

  final HomeViewModel viewModel = HomeViewModel();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('INSPIRAÇÕES'),
          backgroundColor: const Color(0xFFCC8899),
          leading: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF996666),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight * 1.5),
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: viewModel.tabBarBackgroundColor,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: TabBar(
                controller: viewModel.tabController,
                padding: const EdgeInsets.all(5),
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                tabs: [
                  for (var tab in viewModel.tabs) _buildTab(tab.title),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: viewModel.tabController,
          children: const [
            Center(child: Text('Home Content')),
            Center(child: Text('Favorites Content')),
            Center(child: Text('Profile Content')),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String text) {
    final isSelected = viewModel.tabs.any((tab) => tab.title == text) &&
        viewModel.tabs.indexOf(viewModel.tabs.firstWhere((tab) => tab.title == text)) ==
            viewModel.tabController.index;

    return Tab(
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? viewModel.selectedTabColor : viewModel.unselectedTabColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
